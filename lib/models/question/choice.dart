import 'package:deep_connections/utils/loc_key.dart';

class Choice {
  final String id;
  final LocKey text;
  final double? confidence;

  Choice(this.id, this.text, {this.confidence});
}
