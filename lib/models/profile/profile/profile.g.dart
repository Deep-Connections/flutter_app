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
      customGender: json['customGender'] as String?,
      genderPreferences: (json['genderPreferences'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      dateOfBirth: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['dateOfBirth'], const TimestampConverter().fromJson),
      lastMatchedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['lastMatchedAt'], const TimestampConverter().fromJson),
      numMatches: json['numMatches'] as int?,
      height: json['height'] as int?,
      languageCodes: (json['languageCodes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      languageWithCountryCodes:
          (json['languageWithCountryCodes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
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
  writeNotNull('customGender', instance.customGender);
  writeNotNull('genderPreferences', instance.genderPreferences);
  writeNotNull(
      'dateOfBirth',
      _$JsonConverterToJson<Timestamp, DateTime>(
          instance.dateOfBirth, const TimestampConverter().toJson));
  writeNotNull(
      'lastMatchedAt',
      _$JsonConverterToJson<Timestamp, DateTime>(
          instance.lastMatchedAt, const TimestampConverter().toJson));
  writeNotNull('numMatches', instance.numMatches);
  writeNotNull('height', instance.height);
  writeNotNull('languageCodes', instance.languageCodes);
  writeNotNull('languageWithCountryCodes', instance.languageWithCountryCodes);
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
