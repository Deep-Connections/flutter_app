import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:deep_connections/models/chats/reviews/review.dart';
import 'package:deep_connections/models/message/message.dart';
import 'package:deep_connections/services/firebase/firebase_extension.dart';
import 'package:deep_connections/services/utils/handle_firebase_errors.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:deep_connections/utils/logging.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/chats/chat/chat.dart';
import '../firebase_constants.dart';
import '../user/user_service.dart';

const _messagePrefetchLimit = 50;
const _messagePageLimit = 10;

@lazySingleton
class ChatService {
  final UserService _userService;
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;

  ChatService(this._userService, this._firestore, this._functions);

  Query<Message> get _messageGroupQuery => _firestore
      .collectionGroup(Collection.messages)
      .withConverter<Message>(
          fromFirestore: (doc, _) => Message.fromJson(doc.withId()),
          toFirestore: (chat, _) => chat.toJson())
      .where(FieldName.participantIds, arrayContains: _userService.userId)
      .orderBy(FieldName.lastUpdatedAt, descending: true);

  void _addMessages(List<Message> newMessages) {
    if (newMessages.isEmpty) return;
    final messageMap = (newMessages + (_messageSubject.valueOrNull ?? []))
        .fold<Map<String, Message>>(
            {}, (map, message) => map..putIfAbsent(message.id!, () => message));
    final combinedMessages = messageMap.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _messageSubject.add(combinedMessages);
  }

  late final _messageSubject = BehaviorSubject<List<Message>>.seeded([])
    ..let((messageSubject) {
      _userService.userIdStream.forEach((userId) {
        if (userId == null) {
          messageSubject.add([]);
          return;
        }
        logger.d("Message Stream reinitialized");
        /*_messageGroupRef
          .limit(_messagePrefetchLimit)
          .get(*/ /*const GetOptions(source: Source.cache)*/ /*)
          .then((snap) {
        final messages = snap.docs.map((doc) => doc.data()).toList();
        messageSubject.add(messages);
        var streamRef = _messageGroupRef;
        if (messages.isNotEmpty) {
          streamRef = streamRef.where(SerializedField.timestamp,
              isGreaterThan: messages.first.timestamp);
        } else {*/
        _messageGroupQuery.limit(_messagePrefetchLimit).snapshots().listen(
            (e) => _addMessages(
                e.docChanges.mapNotNull((d) => d.doc.data()).toList()));
      });
    });

  Future<bool> loadMoreMessages(String chatId) {
    logger.d("Loading more messages");
    final lastMessage = _messageSubject.valueOrNull
        ?.lastWhereOrNull((message) => message.chatId == chatId);
    var ref = _messagesByChatIdRef(chatId)
        .orderBy(FieldName.createdAt, descending: true);
    if (lastMessage != null) {
      ref = ref.startAfter([lastMessage.createdAt]);
    }
    return ref.limit(_messagePageLimit).get().then((snap) {
      final newMessages = snap.docs.map((doc) => doc.data()).toList();
      _addMessages(newMessages);
      return newMessages.isEmpty;
    });
  }

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
          .where(FieldName.participantIds, arrayContains: userId)
          .snapshots()
          .map((snap) => snap.docs.map((doc) => doc.data()).toList())
          .switchMap((chatList) => _messageSubject.stream
              .map((messages) => chatList.map((chat) {
                    Message? lastMessage;
                    int? unreadMessages;
                    final chatLastRead = chat.lastRead;
                    for (final message in messages) {
                      if (message.chatId == chat.id) {
                        lastMessage ??= message;
                        if (chatLastRead != null &&
                            message.createdAt.isBefore(chatLastRead)) break;
                        unreadMessages ??= 0;
                        if (message.senderId != userId) {
                          unreadMessages++;
                        } else {
                          break;
                        }
                      }
                    }

                    return chat.copyWith(
                        createdAt: lastMessage?.createdAt ?? chat.createdAt,
                        lastMessage: lastMessage,
                        unreadMessages: unreadMessages);
                  }).toList()
                    ..sort((a, b) => b.createdAt.compareTo(a.createdAt)))
              .distinct());
    }));

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

  Stream<List<Chat>> get chatStream => _chatSubject.stream;

  CollectionReference<Message> _messagesByChatIdRef(String chatId) => _chatRef
      .doc(chatId)
      .collection(Collection.messages)
      .withConverter<Message>(
          fromFirestore: (doc, _) => Message.fromJson(doc.withId()),
          toFirestore: (chat, _) => chat.toJson());

  Stream<List<Message>> messagesByChatIdStream(String chatId) =>
      _messageSubject.stream.map((messages) =>
          messages.where((message) => message.chatId == chatId).toList());

  Future<Response<String>> sendMessage(String message, chatId) async {
    final timestamp = DateTime.now();
    final chat = await chatById(chatId);

    final messageObj = Message(
      text: message,
      senderId: _userService.userId,
      createdAt: timestamp,
      lastUpdatedAt: timestamp,
      chatId: chatId,
      participantIds: chat.participantIds,
    );
    final futureMessageResponse = handleFirebaseErrors(
        () async => (await _messagesByChatIdRef(chatId).add(messageObj)).id);

    /*handleFirebaseErrors(() async {
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
    });*/

    return await futureMessageResponse;
  }

  Future<Response<void>> markChatRead(String chatId) async {
    final chat = await chatById(chatId);
    final unreadMessages = chat.unreadMessages;
    if (unreadMessages == 0 || unreadMessages == null) return SuccessRes(null);
    return await handleFirebaseErrors(
        () async => await _chatRef.doc(chatId).update({
              // we set the unread messages to current firebase timestamp
              FieldName.lastReadChat(_userService.userId): Timestamp.now()
            }));
  }

  LocKey? getInitialMatchUiErrorMessages(FirebaseFunctionsException exception) {
    switch (exception.code) {
      case FunctionErrors.notFound:
        return LocKey((loc) => loc.matching_notFoundError);
      case FunctionErrors.alreadyExists:
        return LocKey((loc) => loc.matching_alreadyExistsError);
      case FunctionErrors.failedPrecondition:
        return LocKey((loc) => loc.matching_failedPreconditionError);
    }
    return null;
  }

  Future<Response> createMatch() async {
    try {
      await _functions.httpsCallable(Functions.createInitialMatch)();
      return SuccessRes(null);
    } on FirebaseFunctionsException catch (e) {
      return ErrorRes(
          errorCode: e.code,
          errorMessage: e.message,
          uiMessage: getInitialMatchUiErrorMessages(e));
    }
  }

  Future<Response> unmatch(String chatId, Review? review) {
    final callable = _functions.httpsCallable(Functions.unmatch);
    final Map<String, dynamic> reviewJson = {
      FieldName.chatId: chatId,
    };
    if (review != null) {
      reviewJson[FieldName.review] = review.toJson();
    }

    return handleFirebaseErrors(() async => await callable(reviewJson));
  }
}
