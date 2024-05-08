import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:deep_connections/models/message/message.dart';
import 'package:deep_connections/services/firebase/firebase_extension.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/utils/handle_firebase_errors.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:deep_connections/utils/logging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/chats/chat/chat.dart';
import '../firebase_constants.dart';
import '../user/user_service.dart';

const _messagePrefetchLimit = 50;

@lazySingleton
class ChatService {
  final UserService _userService;
  final ProfileService _profileService;

  ChatService(this._userService, this._profileService);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Chat> get _chatRef {
    return _firestore.collection(Collection.chats).withConverter<Chat>(
        fromFirestore: (doc, _) => Chat.fromJson(doc.withId())
            .copyWith(currentUserId: _userService.userId),
        toFirestore: (chat, _) => chat.toJson());
  }

  late final _chatSubject = BehaviorSubject<List<Chat>>()
    ..addStream(_userService.userIdStream.switchMap((userId) {
      if (userId == null) return const Stream.empty();

      logger.d("Chat Stream reinitialized");
      return _chatRef
          .where(SerializedField.participantIds, arrayContains: userId)
          .orderBy(SerializedField.timestamp, descending: true)
          .snapshots()
          .map((snap) => snap.docs.map((doc) => doc.data()).toList());
    })
      // create a new chat if there are no chats or all chats are older than 24h
      ..firstWhere((chats) {
        if (chats.isEmpty) return true;
        final areAllChatsOlderThan24h = !chats.any((chat) {
          final youngerThan24h = chat.timestamp
                  ?.isAfter(DateTime.now().subtract(const Duration(days: 1))) ??
              false;
          return youngerThan24h;
        });
        return areAllChatsOlderThan24h;
      }).let((asyncChatList) async {
        final chats = await asyncChatList;
        final excludedUsers = chats.mapNotNull((chat) => chat.otherUserId);
        createChat(excludedUsers);
      }));

  Stream<List<Chat>> get chatStream =>
      _chatSubject.stream as Stream<List<Chat>>;

  FutureOr<Chat> chatById(String chatId) {
    final chat =
        _chatSubject.valueOrNull?.firstWhereOrNull((chat) => chat.id == chatId);
    if (chat != null) {
      return chat;
    } else {
      return _chatSubject.stream
          .map((chats) => chats.firstWhereOrNull((chat) => chat.id == chatId))
          .whereNotNull()
          .first;
    }
  }

  Stream<Chat> chatByIdStream(String chatId) => chatStream
      .map((chats) => chats.firstWhereOrNull((chat) => chat.id == chatId))
      .whereNotNull();

  CollectionReference<Message> _messagesRef(String chatId) => _chatRef
      .doc(chatId)
      .collection(Collection.messages)
      .withConverter<Message>(
          fromFirestore: (doc, _) => Message.fromJson(doc.withId()),
          toFirestore: (chat, _) => chat.toJson());

  Query<Message> get _messageGroupRef => _firestore
      .collectionGroup(Collection.messages)
      .withConverter<Message>(
          fromFirestore: (doc, _) => Message.fromJson(doc.withId()),
          toFirestore: (chat, _) => chat.toJson())
      .where(SerializedField.participantIds, arrayContains: _userService.userId)
      .orderBy(SerializedField.timestamp, descending: true);

  List<Message> _combineMessages(List<Message> messages) {
    final messageMap = ((_messageSubject.valueOrNull ?? []) + messages)
        .fold<Map<String, Message>>(
            {}, (map, message) => map..putIfAbsent(message.id!, () => message));
    return messageMap.values.toList()
      ..sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
  }

  late final _messageSubject = BehaviorSubject<List<Message>>()
    ..let((messageSubject) {
      _messageGroupRef
          .limit(_messagePrefetchLimit)
          .get(/*const GetOptions(source: Source.cache)*/)
          .then((snap) {
        final messages = snap.docs.map((doc) => doc.data()).toList();
        messageSubject.add(messages);
        var streamRef = _messageGroupRef;
        if (messages.isNotEmpty) {
          streamRef = streamRef.where(SerializedField.timestamp,
              isGreaterThan: messages.first.timestamp);
        } else {
          streamRef = streamRef.limit(_messagePrefetchLimit);
        }
        final stream = streamRef.snapshots();
        messageSubject.addStream(stream.map((snap) =>
            _combineMessages(snap.docs.map((doc) => doc.data()).toList())));
      });
      return messageSubject;
    });

  Stream<List<Message>> messageStream(String chatId) =>
      _messageSubject.stream.map((messages) =>
          messages.where((message) => message.chatId == chatId).toList());

  /* Stream<List<Message>> messageStream(String chatId) => _messagesRef(chatId)
      .orderBy(SerializedField.timestamp, descending: true)
      .snapshots()
      .map((snap) => snap.docs.map((doc) => doc.data()).toList());*/

  Future<Response<String>> sendMessage(String message, chatId) async {
    final timestamp = DateTime.now();
    final chat = await chatById(chatId);

    final messageObj = Message(
      text: message,
      senderId: _userService.userId,
      timestamp: timestamp,
      chatId: chatId,
      participantIds: chat.participantIds,
    );
    final futureMessageResponse = handleFirebaseErrors(
        () async => (await _messagesRef(chatId).add(messageObj)).id);

    handleFirebaseErrors(() async {
      final updateChatJson = Chat(
        lastMessage: messageObj,
        timestamp: timestamp,
      ).toJson();

      chat.participantIds?.forEach((userId) {
        // when the user sends a message we mark the chat as completely unread with 0 messages
        updateChatJson[Update.unreadMessages(userId)] =
            userId != chat.currentUserId ? FieldValue.increment(1) : 0;
      });
      return await _chatRef.doc(chatId).update(updateChatJson);
    });

    return await futureMessageResponse;
  }

  Future<Response<void>> markChatRead(String chatId) async {
    final chat = await chatById(chatId);
    final unreadMessages = chat.info?.unreadMessages;
    if (unreadMessages == 0 || unreadMessages == null) return SuccessRes(null);
    return await handleFirebaseErrors(
        () async => await _chatRef.doc(chatId).update({
              // we set the unread messages to null, so the chat still shows up as unread but with 0 messages
              Update.unreadMessages(_userService.userId): null,
            }));
  }

  Future<Response<String?>> createChat(List<String> excludedUsers) async {
    final newMatch = await _profileService.getNewMatch(excludedUsers);
    final matchUserId = newMatch?.id;

    if (matchUserId != null) {
      final chat = Chat(
        timestamp: DateTime.now(),
        participantIds: [_userService.userId, matchUserId],
      );
      return await handleFirebaseErrors(
          () async => (await _chatRef.add(chat)).id);
    }
    return SuccessRes(null);
  }

  createMatch() async {
    final app = Firebase.app();
    logger.d(app.name);
    final callable = FirebaseFunctions.instanceFor(region: "europe-west6")
        .httpsCallable('createInitialMatch');

    try {
      final response = await callable();
      // Handle response here
      logger.d('Function executed successfully');
    } on FirebaseFunctionsException catch (e) {
      // Handle function error
      logger.d('Error executing function: ${e.code} ${e.message} ${e.details}');
      logger.e(e);
    } catch (e) {
      // Handle other errors
      logger.d('Error: $e');
    }
  }
}
