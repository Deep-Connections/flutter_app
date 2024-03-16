import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  final String? uid, name, gender;
  final List<String>? genderLookingFor;
  final DateTime? dateOfBirth;
  final int? height;

  Profile({
    this.uid,
    this.name,
    this.gender,
    this.genderLookingFor,
    this.dateOfBirth,
    this.height,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
