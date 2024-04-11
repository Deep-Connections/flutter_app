import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/models/message/message.dart';
import 'package:deep_connections/services/firebase/firebase_extension.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/utils/handle_firebase_errors.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/chats/chat/chat.dart';
import '../firebase_constants.dart';
import '../user/user_service.dart';

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

      print("Chat Stream reinitialized");
      return _chatRef
          .where(SerializedField.participantIds, arrayContains: userId)
          .orderBy(SerializedField.timestamp, descending: true)
          .snapshots()
          .map((snap) => snap.docs
              .map((doc) => doc.data())
              .map((chat) => chat.copyWith(
                  chatInfos: chat.chatInfos
                      ?.where((info) => info.userId != userId)
                      .toList()))
              .toList());
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
        _chatSubject.value.firstWhereOrNull((chat) => chat.id == chatId);
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

  Stream<List<Message>> messageStream(String chatId) => _messagesRef(chatId)
      .orderBy(SerializedField.timestamp, descending: true)
      .snapshots()
      .map((snap) => snap.docs.map((doc) => doc.data()).toList());

  Future<Response<String>> sendMessage(String message, chatId) {
    final timestamp = DateTime.now();
    final messageObj = Message(
      text: message,
      senderId: _userService.userId,
      timestamp: timestamp,
    );
    return handleFirebaseErrors(() async {
      _chatRef
          .doc(chatId)
          .update(Chat(lastMessage: messageObj, timestamp: timestamp).toJson());
      return (await _messagesRef(chatId).add(messageObj)).id;
    });
  }

  Future<Response<String?>> createChat(List<String> excludedUsers) async {
    final newMatch = await _profileService.getNewMatch(excludedUsers);
    final matchUserId = newMatch?.uid;

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
}
