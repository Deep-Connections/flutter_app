// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      gender: json['gender'] as String?,
      genderPreferences: (json['genderPreferences'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      dateOfBirth: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['dateOfBirth'], const TimestampConverter().fromJson),
      height: json['height'] as int?,
      languageCodes: (json['languageCodes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      languageWithCountryCodes:
          (json['languageWithCountryCodes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      profilePicture: json['profilePicture'] == null
          ? null
          : Picture.fromJson(json['profilePicture'] as Map<String, dynamic>),
      pictures: (json['pictures'] as List<dynamic>?)
          ?.map((e) => Picture.fromJson(e as Map<String, dynamic>))
          .toList(),
      questions: (json['questions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Answer.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('gender', instance.gender);
  writeNotNull('genderPreferences', instance.genderPreferences);
  writeNotNull(
      'dateOfBirth',
      _$JsonConverterToJson<Timestamp, DateTime>(
          instance.dateOfBirth, const TimestampConverter().toJson));
  writeNotNull('height', instance.height);
  writeNotNull('languageCodes', instance.languageCodes);
  writeNotNull('languageWithCountryCodes', instance.languageWithCountryCodes);
  writeNotNull('profilePicture', instance.profilePicture?.toJson());
  writeNotNull('pictures', instance.pictures?.map((e) => e.toJson()).toList());
  writeNotNull(
      'questions', instance.questions?.map((k, e) => MapEntry(k, e.toJson())));
  return val;
}

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
