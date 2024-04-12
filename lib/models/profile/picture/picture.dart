
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_connections/models/converters/timestamp_converter.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'picture.freezed.dart';
part 'picture.g.dart';

@freezed
class Picture with _$Picture {
  const factory Picture({
    String? url,
    String? name,
    @TimestampConverter()
    DateTime? timestamp,
  }) = _Picture;

  factory Picture.fromJson(Map<String, dynamic> json) =>
      _$PictureFromJson(json);
}
