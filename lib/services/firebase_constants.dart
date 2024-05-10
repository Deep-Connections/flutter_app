class Collection {
  static const profiles = 'profiles';
  static const chats = 'chats';
  static const messages = 'messages';
}

class SerializedField {
  static const timestamp = 'timestamp';
  static const participantIds = 'participantIds';
  static const pictures = 'pictures';
  static const profilePicture = 'profilePicture';
  static const id = 'id';
}

class Update {
  static lastReadChat(userId) => "chatInfos.$userId.lastRead";
}

class StorageCollection {
  static const profileImages = 'profile_images';
}
