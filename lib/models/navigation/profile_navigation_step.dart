import 'package:deep_connections/models/navigation/navigation_step.dart';
import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/cupertino.dart';

abstract class ProfileNavigationStep<T> extends NavigationStep {
  T? fromProfile(Profile profile);

  final LocKey title;
  final ProfileSection section;
  final bool isEditable;

  const ProfileNavigationStep({required super.navigationPath,
    required this.section,
    required this.title,
    this.isEditable = true});
}

class ProfileNavigationStepWithWidget<T> extends ProfileNavigationStep<T> {
  final Widget Function(ProfileService profileService,
      Future<void> Function() onSubmit, LocKey submitText) createWidget;

  final T? Function(Profile) _fromProfile;

  @override
  T? fromProfile(Profile profile) => _fromProfile(profile);

  ProfileNavigationStepWithWidget(
      {required super.navigationPath,
      required T? Function(Profile) fromProfile,
      required super.title,
      required this.createWidget,
      super.isEditable = true})
      : _fromProfile = fromProfile,
        super(section: ProfileSection.basic);
}
