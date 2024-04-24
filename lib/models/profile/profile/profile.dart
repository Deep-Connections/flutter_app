import 'package:deep_connections/models/profile/picture/picture.dart';
import 'package:deep_connections/models/question/answer/answer.dart';
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
    Map<String, Answer>? questions,
  }) = _Profile;

  String? get mainPictureUrl => pictures?.lastOrNull?.url;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
