// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatInfoImpl _$$ChatInfoImplFromJson(Map<String, dynamic> json) =>
    _$ChatInfoImpl(
      userId: json['userId'] as String?,
      unreadMessages: json['unreadMessages'] as bool?,
    );

Map<String, dynamic> _$$ChatInfoImplToJson(_$ChatInfoImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userId', instance.userId);
  writeNotNull('unreadMessages', instance.unreadMessages);
  return val;
}
