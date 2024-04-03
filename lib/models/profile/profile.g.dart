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
      genderPreferences: (json['genderPreferences'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      height: json['height'] as int?,
      question1: json['question1'] == null
          ? null
          : QuestionResponse.fromJson(
              json['question1'] as Map<String, dynamic>),
      question2: json['question2'] == null
          ? null
          : QuestionResponse.fromJson(
              json['question2'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'firstName': instance.firstName,
      'gender': instance.gender,
      'genderPreferences': instance.genderPreferences,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'height': instance.height,
      'question1': instance.question1,
      'question2': instance.question2,
    };
