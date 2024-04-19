import 'package:deep_connections/models/profile/picture/picture.dart';
import 'package:deep_connections/models/question/response/question_response.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  const Profile._();

  const factory Profile({
    String? id,
    String? firstName,
    String? gender,
    List<String>? genderPreferences,
    DateTime? birthdate,
    int? height,
    Picture? profilePicture,
    List<Picture>? pictures,
    Map<String, QuestionResponse>? questions,
    QuestionResponse? question1,
    QuestionResponse? question2,
    QuestionResponse? question3,
    QuestionResponse? question4,
    QuestionResponse? question5,
    QuestionResponse? question6,
    QuestionResponse? question7,
    QuestionResponse? question8,
    QuestionResponse? question9,
    QuestionResponse? question10,
    QuestionResponse? question11,
    QuestionResponse? question12,
  }) = _Profile;

  String? get mainPictureUrl => pictures?.lastOrNull?.url;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
