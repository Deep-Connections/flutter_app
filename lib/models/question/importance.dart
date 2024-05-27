import 'package:deep_connections/utils/loc_key.dart';

class Importance {
  final double value;
  final LocKey label;

  const Importance(this.value, this.label);

  static final low =
      Importance(0.0, LocKey((loc) => loc.question_importance_low));
  static final medium =
      Importance(0.5, LocKey((loc) => loc.question_importance_medium));
  static final high =
      Importance(1.0, LocKey((loc) => loc.question_importance_high));

  static final values = [low, medium, high];
}
