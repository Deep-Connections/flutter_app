// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      uid: json['uid'] as String?,
      firstName: json['firstName'] as String?,
      gender: json['gender'] as String?,
      genderLookingFor: (json['genderLookingFor'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      height: json['height'] as int?,
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'firstName': instance.firstName,
      'gender': instance.gender,
      'genderLookingFor': instance.genderLookingFor,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'height': instance.height,
    };
