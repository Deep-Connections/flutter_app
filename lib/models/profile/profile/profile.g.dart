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
      birthdate: json['birthdate'] == null
          ? null
          : DateTime.parse(json['birthdate'] as String),
      height: json['height'] as int?,
      question1: json['question1'] == null
          ? null
          : QuestionResponse.fromJson(
              json['question1'] as Map<String, dynamic>),
      question2: json['question2'] == null
          ? null
          : QuestionResponse.fromJson(
              json['question2'] as Map<String, dynamic>),
      question3: json['question3'] == null
          ? null
          : QuestionResponse.fromJson(
              json['question3'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('gender', instance.gender);
  writeNotNull('genderPreferences', instance.genderPreferences);
  writeNotNull('birthdate', instance.birthdate?.toIso8601String());
  writeNotNull('height', instance.height);
  writeNotNull('question1', instance.question1?.toJson());
  writeNotNull('question2', instance.question2?.toJson());
  writeNotNull('question3', instance.question3?.toJson());
  return val;
}
