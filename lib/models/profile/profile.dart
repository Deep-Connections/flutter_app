import 'package:deep_connections/models/question/response/question_response.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    String? uid,
    String? firstName,
    String? gender,
    List<String>? genderPreferences,
    DateTime? dateOfBirth,
    int? height,
    QuestionResponse? question1,
    QuestionResponse? question2,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

}
