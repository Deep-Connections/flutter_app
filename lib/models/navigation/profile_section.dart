import 'package:deep_connections/utils/loc_key.dart';

class ProfileSection {
  final LocKey title;

  const ProfileSection._(this.title);

  static final ProfileSection profile =
      ProfileSection._(LocKey((loc) => loc.section_profile));
  static final ProfileSection personality =
      ProfileSection._(LocKey((loc) => loc.section_personality));
  static final ProfileSection habits =
      ProfileSection._(LocKey((loc) => loc.section_habits));
  static final ProfileSection spirituality =
      ProfileSection._(LocKey((loc) => loc.section_spirituality));
  static final ProfileSection politics =
      ProfileSection._(LocKey((loc) => loc.section_politics));
  static final ProfileSection family =
      ProfileSection._(LocKey((loc) => loc.section_family));
  static final ProfileSection freeTime =
      ProfileSection._(LocKey((loc) => loc.section_freeTime));
}
