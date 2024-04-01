import 'package:deep_connections/utils/extensions/nullable.dart';
import 'package:deep_connections/utils/loc_key.dart';

class Gender {
  final String enumValue;
  final LocKey localizedName;

  Gender(this.enumValue, this.localizedName);

  String localize(loc) => localizedName.localize(loc);

  // base
  static final man = Gender('MAN', LocKey((loc) => loc.input_genderEnumMan));
  static final woman =
      Gender('WOMAN', LocKey((loc) => loc.input_genderEnumWoman));

  // additional genders, not used yet
  static final nonBinary =
      Gender("NON_BINARY", LocKey((loc) => loc.input_genderEnumNonBinary));
  static final interSex =
      Gender("INTERSEX", LocKey((loc) => loc.input_genderEnumIntersex));

  static final transWoman =
      Gender("TRANS_WOMAN", LocKey((loc) => loc.input_genderEnumTransWoman));
  static final transMan =
      Gender("TRANS_MAN", LocKey((loc) => loc.input_genderEnumTransMan));

  // everyone
  static final everyone =
      Gender("EVERYONE", LocKey((loc) => loc.input_genderEnumEveryone));

  static final List<Gender> base = [woman, man];

  //static final List<Gender> genderLookingFor = base + [everyone];
  static final List<Gender> additional = [
    nonBinary,
    interSex,
    transWoman,
    transMan
  ];

  static final List<Gender> all = base + additional + [everyone];

  static fromEnum(String? enumValue) {
    if (enumValue == null) return null;
    return all.firstWhereOrNull((gender) => gender.enumValue == enumValue);
  }
}
