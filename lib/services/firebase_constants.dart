class Collection {
  static const profiles = 'profiles';
  static const chats = 'chats';
  static const messages = 'messages';
}

class FieldName {
  static const createdAt = 'createdAt';
  static const lastUpdatedAt = 'lastUpdatedAt';
  static const participantIds = 'participantIds';
  static const pictures = 'pictures';
  static const profilePicture = 'profilePicture';
  static const chatId = 'chatId';
  static const id = 'id';

  static String lastReadChat(userId) => "chatInfos.$userId.lastRead";
}

class Functions {
  static const createInitialMatch = 'createInitialMatch';
  static const unmatch = 'unmatch';
  static const deleteAccount = 'deleteAccount';
}

class Regions {
  static const europeWest6 = 'europe-west6';
}

class StorageCollection {
  static const profileImages = 'profile_images';
}

class FunctionErrors {
  static const String ok = 'ok'; // (200) - No error, operation successful.
  static const String invalidArgument =
      'invalid-argument'; // (400) - Client specified an invalid argument.
  static const String outOfRange =
      'out-of-range'; // (400) - Operation was attempted past the valid range.
  static const String unauthenticated =
      'unauthenticated'; // (401) - The request does not have valid authentication credentials for the operation.
  static const String permissionDenied =
      'permission-denied'; // (403) - The caller does not have permission to execute the specified operation.
  static const String notFound =
      'not-found'; // (404) - Specified resource was not found.
  static const String aborted =
      'aborted'; // (409) - Operation was aborted, typically due to a concurrency issue like the transaction aborts, etc.
  static const String alreadyExists =
      'already-exists'; // (409) - The resource being created already exists.
  static const String failedPrecondition =
      'failed-precondition'; // (412) - Operation was rejected because the system is not in a state required for the operation's execution.
  static const String resourceExhausted =
      'resource-exhausted'; // (429) - Some resource has been exhausted, perhaps a per-user quota, or perhaps the entire file system is out of space.
  static const String cancelled =
      'cancelled'; // (499) - Client cancelled the request.
  static const String internal = 'internal'; // (500) - Internal server error.
  static const String unknown = 'unknown'; // (500) - Unknown error occurred.
  static const String dataLoss =
      'data-loss'; // (500) - Unrecoverable data loss or corruption.
  static const String unavailable =
      'unavailable'; // (503) - The service is currently unavailable (overloaded or down).
  static const String notImplemented =
      'unimplemented'; // (501) - Operation is not implemented or not supported/enabled in this service.
  static const String deadlineExceeded =
      'deadline-exceeded'; // (504) - Deadline expired before operation could complete.
}

class StorageErrors {
  static const String objectNotFound = 'object-not-found';
  static const String unauthorized = 'unauthorized';
}