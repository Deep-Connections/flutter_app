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
      pictures: (json['pictures'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
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
      question4: json['question4'] == null
          ? null
          : QuestionResponse.fromJson(
              json['question4'] as Map<String, dynamic>),
      question5: json['question5'] == null
          ? null
          : QuestionResponse.fromJson(
              json['question5'] as Map<String, dynamic>),
      question6: json['question6'] == null
          ? null
          : QuestionResponse.fromJson(
              json['question6'] as Map<String, dynamic>),
      question7: json['question7'] == null
          ? null
          : QuestionResponse.fromJson(
              json['question7'] as Map<String, dynamic>),
      question8: json['question8'] == null
          ? null
          : QuestionResponse.fromJson(
              json['question8'] as Map<String, dynamic>),
      question9: json['question9'] == null
          ? null
          : QuestionResponse.fromJson(
              json['question9'] as Map<String, dynamic>),
      question10: json['question10'] == null
          ? null
          : QuestionResponse.fromJson(
              json['question10'] as Map<String, dynamic>),
      question11: json['question11'] == null
          ? null
          : QuestionResponse.fromJson(
              json['question11'] as Map<String, dynamic>),
      question12: json['question12'] == null
          ? null
          : QuestionResponse.fromJson(
              json['question12'] as Map<String, dynamic>),
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
  writeNotNull('pictures', instance.pictures);
  writeNotNull('question1', instance.question1?.toJson());
  writeNotNull('question2', instance.question2?.toJson());
  writeNotNull('question3', instance.question3?.toJson());
  writeNotNull('question4', instance.question4?.toJson());
  writeNotNull('question5', instance.question5?.toJson());
  writeNotNull('question6', instance.question6?.toJson());
  writeNotNull('question7', instance.question7?.toJson());
  writeNotNull('question8', instance.question8?.toJson());
  writeNotNull('question9', instance.question9?.toJson());
  writeNotNull('question10', instance.question10?.toJson());
  writeNotNull('question11', instance.question11?.toJson());
  writeNotNull('question12', instance.question12?.toJson());
  return val;
}
