import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/services/firebase/firebase_extension.dart';
import 'package:injectable/injectable.dart';

import '../../models/chat.dart';
import '../firebase_constants.dart';
import '../user/user_service.dart';

@lazySingleton
class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserService userService;

  ChatService(this.userService);

  Query<Map<String, dynamic>> _getChatRef() {
    final currentUserId = userService.userId;
    return _firestore
        .collection(Collection.chats)
        .where('participantIds', arrayContains: currentUserId);
  }

  Stream<List<Chat>> getChatStream() {
    return _getChatRef()
        .snapshots().map(
        (snap) => snap.docs.map((doc) => Chat.fromJson(doc.withId())).toList());
  }

  Future<void> createChat(String otherUserId) async {
    final chat = Chat(
      participantIds: [userService.userId, otherUserId],
    );
    await _firestore.collection(Collection.chats).add(chat.toJson());
  }
}
