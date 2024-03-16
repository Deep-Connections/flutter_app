import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Message {
  String? id;
  String? senderId;
  String? text;
  DateTime? timestamp;

  Message({this.id, this.senderId, this.text, this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
