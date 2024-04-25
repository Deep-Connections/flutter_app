import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/services/firebase_constants.dart';
import 'package:deep_connections/utils/logging.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/message/message.dart';

class OptimizedMessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final BehaviorSubject<List<Message>> _messagesSubject =
      BehaviorSubject<List<Message>>.seeded([]);
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _realTimeSub;
  final String chatId;
  DocumentSnapshot? _lastDocument;
  bool _hasMoreMessages = true;
  bool _isLoading = false;

  Stream<List<Message>> get messagesStream => _messagesSubject.stream;

  OptimizedMessageService(this.chatId) {
    loadMoreMessages();
    _listenToNewMessages();
  }

  CollectionReference<Map<String, dynamic>> getMessagesRef() {
    return _firestore
        .collection(Collection.chats)
        .doc(chatId)
        .collection(Collection.messages);
  }

  addMessages(List<Message> messages) {
    final currentMessages = _messagesSubject.value + messages;
    currentMessages.sort((a, b) {
      if (a.timestamp == null) return 1;
      if (b.timestamp == null) return -1;
      return a.timestamp!.compareTo(b.timestamp!);
    });
    _messagesSubject.add(currentMessages);
  }

  void _listenToNewMessages() {
    _realTimeSub = getMessagesRef()
        .where(SerializedField.timestamp, isGreaterThan: DateTime.now())
        .orderBy(SerializedField.timestamp, descending: true)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
      }
      var messages =
          snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList();
      logger.d('New messages: $messages');
      addMessages(messages);
    });
  }

  Future<void> loadMoreMessages() async {
    if (!_hasMoreMessages || _isLoading) return;
    _isLoading = true;

    var query = getMessagesRef()
        .orderBy(SerializedField.timestamp, descending: true)
        .limit(20);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    var snapshot = await query.get();
    if (snapshot.docs.isEmpty) {
      _hasMoreMessages = false;
    } else {
      _lastDocument = snapshot.docs.last;
      var moreMessages =
          snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList();
      logger.d('Load more messages: $moreMessages');
      addMessages(moreMessages);
    }
    _isLoading = false;
  }

  void dispose() {
    _realTimeSub.cancel();
    _messagesSubject.close();
  }
}
