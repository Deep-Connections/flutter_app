class Collection {
  static const profiles = 'profiles';
  static const chats = 'chats';
  static const messages = 'messages';
}

class FieldName {
  static const createdAt = 'createdAt';
  static const participantIds = 'participantIds';
  static const pictures = 'pictures';
  static const profilePicture = 'profilePicture';
  static const id = 'id';

  static String lastReadChat(userId) => "chatInfos.$userId.lastRead";
}

class Functions {
  static const createInitialMatch = 'createInitialMatch';
}

class Regions {
  static const europeWest6 = 'europe-west6';
}

class StorageCollection {
  static const profileImages = 'profile_images';
}
