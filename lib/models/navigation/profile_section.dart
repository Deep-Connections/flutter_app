import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:deep_connections/utils/loc_key.dart';

class ProfileSection {
  final LocKey title;
  final String path;

  const ProfileSection._(this.title, this.path);

  static final ProfileSection profile =
      ProfileSection._(LocKey((loc) => loc.section_profile), "profile");
  static final ProfileSection personality =
      ProfileSection._(LocKey((loc) => loc.section_personality), "personality");
  static final ProfileSection habits =
      ProfileSection._(LocKey((loc) => loc.section_habits), "habits");
  static final ProfileSection spirituality = ProfileSection._(
      LocKey((loc) => loc.section_spirituality), "spirituality");
  static final ProfileSection politics =
      ProfileSection._(LocKey((loc) => loc.section_politics), "politics");
  static final ProfileSection family =
      ProfileSection._(LocKey((loc) => loc.section_family), "family");
  static final ProfileSection freeTime =
      ProfileSection._(LocKey((loc) => loc.section_freeTime), "freeTime");
  static final values = [
    profile,
    personality,
    habits,
    spirituality,
    politics,
    family,
    freeTime,
  ];

  static ProfileSection? fromPath(String? path) {
    return values.firstWhereOrNull((section) => section.path == path);
  }
}
