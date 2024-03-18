import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/services/utils/user_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../models/chat.dart';
import '../firebase_constants.dart';

@lazySingleton
class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /*final BehaviorSubject<List<Chat>> _chatSubject =
  BehaviorSubject<List<Chat>>.seeded([]);*/

  Query<Map<String, dynamic>> _getChatRef() {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) throw UserNotFoundException();
    return _firestore
        .collection(Collection.chats)
        .where('participantIds', arrayContains: currentUserId);
  }

  Stream<List<Chat>> getChatStream() {
    return _getChatRef()
        .snapshots()
        .map((snap) => snap.docs.map((e) => Chat.fromJson(e.data())).toList());
  }
}
