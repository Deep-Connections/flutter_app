// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionResponseImpl _$$QuestionResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$QuestionResponseImpl(
      questionId: json['questionId'] as String?,
      questionType: json['questionType'] as String?,
      answerValue: json['answerValue'] as int?,
    );

Map<String, dynamic> _$$QuestionResponseImplToJson(
        _$QuestionResponseImpl instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'questionType': instance.questionType,
      'answerValue': instance.answerValue,
    };
