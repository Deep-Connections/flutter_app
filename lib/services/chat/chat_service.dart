import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/models/chats/info/chat_info.dart';
import 'package:deep_connections/models/message/message.dart';
import 'package:deep_connections/services/firebase/firebase_extension.dart';
import 'package:deep_connections/services/utils/handle_firebase_errors.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/chats/chat/chat.dart';
import '../firebase_constants.dart';
import '../user/user_service.dart';

const testImageUrl =
    "https://preview.redd.it/i-got-bored-so-i-decided-to-draw-a-random-image-on-the-v0-4ig97vv85vjb1.png?width=640&crop=smart&auto=webp&s=22ed6cc79cba3013b84967f32726d087e539b699";

@lazySingleton
class ChatService {
  final UserService _userService;

  ChatService(this._userService);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Chat> get _chatRef {
    return _firestore.collection(Collection.chats).withConverter<Chat>(
        fromFirestore: (doc, _) => Chat.fromJson(doc.withId()),
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
    }));

  Stream<List<Chat>> get chatStream =>
      _chatSubject.stream as Stream<List<Chat>>;

  Stream<Chat?> chatByIdStream(String chatId) => chatStream
      .map((chats) => chats.firstWhereOrNull((chat) => chat.id == chatId));

  CollectionReference<Message> _messagesRef(String chatId) => _chatRef
      .doc(chatId)
      .collection(Collection.messages)
      .withConverter<Message>(
          fromFirestore: (doc, _) => Message.fromJson(doc.withId()),
          toFirestore: (chat, _) => chat.toJson());

  Stream<List<Message>> messageStream(String chatId) => _messagesRef(chatId)
      .snapshots()
      .map((snap) => snap.docs.map((doc) => doc.data()).toList());

  sendMessage(String message, chatId) {
    final messageObj = Message(
      text: message,
      senderId: _userService.userId,
      timestamp: DateTime.now(),
    );
    _messagesRef(chatId).add(messageObj);
  }

  Future<Response<String>> createChat(String otherUserId) async {
    final chat = Chat(
      timestamp: DateTime.now(),
      participantIds: [_userService.userId, otherUserId],
      lastMessage: Message(senderId: otherUserId, text: "Sina's test message"),
      chatInfos: [
        ChatInfo(
            userId: _userService.userId, name: "Jari", imageUrl: testImageUrl),
        ChatInfo(
          userId: "FHzjtq4N3yZf1wo9xr1nYoM2EHA2",
          name: "Sina",
          imageUrl: testImageUrl,
        ),
      ],
    );
    return await handleFirebaseErrors(
        () async => (await _chatRef.add(chat)).id);
  }
}
