import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/services/firebase_constants.dart';

extension QueryDocumentSnapshotExtension
    on QueryDocumentSnapshot<Map<String, dynamic>> {
  Map<String, dynamic> withId() {
    var dataWithId = data();
    dataWithId[SerializedField.id] = dataWithId[SerializedField.id] ??
        id; // Adds the document ID if not present
    return dataWithId;
  }
}
