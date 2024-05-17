import 'package:deep_connections/utils/logging.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'response.dart';

Future<Response<T>> handleFirebaseErrors<T>(
  Future<T> Function() callback,
) async {
  try {
    return SuccessRes(await callback());
  } on FirebaseException catch (e) {
    logger.e("Firebase error: ${e.code}", error: e);
    return ErrorRes(errorCode: e.code, errorMessage: e.message);
  }
}
