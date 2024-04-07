import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/utils/loc_key.dart';

class SliderQuestion extends Question {
  final int minValue;
  final int maxValue;
  final int defaultValue;
  final LocKey minText;
  final LocKey maxText;

  get divisions => maxValue - minValue;

  SliderQuestion({
    required super.id,
    required super.questionText,
    required this.minValue,
    required this.maxValue,
    int? defaultValue,
    required this.minText,
    required this.maxText,
    required super.navigationPath,
    required super.fromProfile,
    required super.updateProfile,
    required super.section,
  }) : defaultValue = defaultValue ?? (minValue + maxValue) ~/ 2;
}
