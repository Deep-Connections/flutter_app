import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Chat {
  String? id;
  final List<String>? participantIds;

  Chat({this.id, this.participantIds});

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
