import 'package:firebase_auth/firebase_auth.dart';

import '../models/response.dart';

Future<Response<T>> handleFirebaseErrors<T>(
  Future<T> Function() callback,
) async {
  try {
    return SuccessRes(await callback());
  } on FirebaseException catch (e) {
    return ErrorRes(errorCode: e.code, errorMessage: e.message);
  }
}
