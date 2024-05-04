// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnswerImpl _$$AnswerImplFromJson(Map<String, dynamic> json) => _$AnswerImpl(
      choices:
          (json['choices'] as List<dynamic>?)?.map((e) => e as String).toList(),
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$AnswerImplToJson(_$AnswerImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('choices', instance.choices);
  writeNotNull('value', instance.value);
  return val;
}
