// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatImpl _$$ChatImplFromJson(Map<String, dynamic> json) => _$ChatImpl(
      participantIds: (json['participantIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      chatInfos: (json['chatInfos'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, ChatInfo.fromJson(e as Map<String, dynamic>)),
      ),
      id: json['id'] as String?,
      lastMessage: json['lastMessage'] == null
          ? null
          : Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
      unreadMessages: json['unreadMessages'] as int?,
      currentUserId: json['currentUserId'] as String?,
    );

Map<String, dynamic> _$$ChatImplToJson(_$ChatImpl instance) {
  final val = <String, dynamic>{
    'participantIds': instance.participantIds,
    'createdAt': const TimestampConverter().toJson(instance.createdAt),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'chatInfos', instance.chatInfos?.map((k, e) => MapEntry(k, e.toJson())));
  writeNotNull('id', instance.id);
  writeNotNull('lastMessage', instance.lastMessage?.toJson());
  writeNotNull('unreadMessages', instance.unreadMessages);
  writeNotNull('currentUserId', instance.currentUserId);
  return val;
}
