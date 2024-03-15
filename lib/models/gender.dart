import 'package:deep_connections/utils/loc_key.dart';

class Gender {
  final String enumValue;
  final LocKey localizedName;

  Gender(this.enumValue, this.localizedName);

  static final Gender male =
      Gender('Male', LocKey((loc) => loc.input_genderEnumMale));
  static final Gender female =
      Gender('Female', LocKey((loc) => loc.input_genderEnumFemale));

  static List<Gender> get values => [female, male];
}
