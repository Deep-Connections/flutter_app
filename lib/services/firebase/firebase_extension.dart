import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/services/firebase_constants.dart';

import 'firebase_exceptions.dart';

extension QueryDocumentSnapshotExtension
    on QueryDocumentSnapshot<Map<String, dynamic>> {
  Map<String, dynamic> withId() {
    var dataWithId = data();
    dataWithId[FieldName.id] = id;
    return dataWithId;
  }
}

extension DocumentSnapshotExtension on DocumentSnapshot<Map<String, dynamic>> {
  Map<String, dynamic> withId() {
    var dataWithId = data();
    if (dataWithId == null) throw DocumentSnapshotNullException();
    dataWithId[FieldName.id] = id;
    return dataWithId;
  }
}

// generic extension thet gets the data or throws an exception
extension DocumentSnapshotDataExtension<T> on DocumentSnapshot<T> {
  T get dataOrThrow {
    var data = this.data();
    if (data == null) throw DocumentSnapshotNullException();
    return data;
  }
}
