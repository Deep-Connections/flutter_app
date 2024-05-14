
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:deep_connections/utils/loc_key.dart';

class Gender {
  final String enumValue;
  final LocKey? localizedName;
  String? customName;

  Gender(this.enumValue, this.localizedName);

  static fromCustomName(String customName) => other..customName = customName;

  String localize(loc) => customName ?? localizedName?.localize(loc) ?? "";

  // base
  static final man = Gender('MAN', LocKey((loc) => loc.input_genderEnumMan));
  static final woman =
      Gender('WOMAN', LocKey((loc) => loc.input_genderEnumWoman));

  // additional genders
  static final nonBinary =
      Gender("NON_BINARY", LocKey((loc) => loc.input_genderEnumNonBinary));

  static final transWoman =
      Gender("TRANS_WOMAN", LocKey((loc) => loc.input_genderEnumTransWoman));
  static final transMan =
      Gender("TRANS_MAN", LocKey((loc) => loc.input_genderEnumTransMan));

  static final genderFluid =
      Gender("GENDER_FLUID", LocKey((loc) => loc.input_genderEnumGenderFluid));

  static final agender =
      Gender("AGENDER", LocKey((loc) => loc.input_genderEnumAgender));

  static Gender get other =>
      Gender("OTHER", LocKey((loc) => loc.input_genderEnumOther));

  // everyone
  static final everyone =
      Gender("EVERYONE", LocKey((loc) => loc.input_genderEnumEveryone));

  static final List<Gender> base = [woman, man];

  static final List<Gender> additional = [
    nonBinary,
    transWoman,
    transMan,
    genderFluid,
    agender
  ];

  static final additionalOther = additional + [other];

  static final List<Gender> values = base + additionalOther;

  static fromEnum(String? enumValue) {
    if (enumValue == null) return null;
    return (values + [everyone])
        .firstWhereOrNull((gender) => gender.enumValue == enumValue);
  }
}
