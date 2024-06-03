import 'package:deep_connections/models/navigation/profile_navigation_step.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/models/question/question.dart';
import 'package:deep_connections/screens/question/question_screen.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/utils/error_handling.dart';
import 'package:deep_connections/services/utils/response.dart';
import 'package:deep_connections/utils/loc_key.dart';
import 'package:flutter/material.dart';

class ProfileStepWidget extends StatelessWidget {
  final ProfileNavigationStep step;
  final ProfileService profileService;
  final LocKey submitText;
  final void Function(Profile newProfile)? navigate;
  final Future<void> Function(Profile profile)? afterProfileUpdate;

  const ProfileStepWidget({
    super.key,
    required this.step,
    this.navigate,
    required this.profileService,
    required this.submitText,
    this.afterProfileUpdate,
  });

  Future<Response<void>> _updateProfile(
      Profile Function(Profile profile) transform) async {
    final response = await profileService.updateProfile(transform,
        onUpdatedProfile: navigate);
    final afterProfileUpdate = this.afterProfileUpdate;
    if (response is SuccessRes<Profile> && afterProfileUpdate != null) {
      await afterProfileUpdate(response.data);
    }
    MessageHandler.showResponseError(response);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final navigationStep = step;
    if (navigationStep is ProfileNavigationStepWithWidget) {
      return navigationStep.createWidget(
          profileService.profileStream, _updateProfile, submitText);
    } else if (navigationStep is Question) {
      return QuestionScreen(
          question: navigationStep,
          profileStream: profileService.profileStream,
          updateProfile: _updateProfile,
          submitText: submitText);
    } else {
      throw Exception("Unknown navigation step type: $navigationStep");
    }
  }
}
