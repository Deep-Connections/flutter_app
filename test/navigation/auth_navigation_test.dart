import 'package:deep_connections/config/injectable/injectable.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/navigation/graphs/auth_nav_graph.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/user/user_status_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../services/mock_profile_service.dart';

// ignore: must_be_immutable
class MockGoRouterState extends Mock implements GoRouterState {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late final MockProfileService profileService;
  setUpAll(() {
    // Setup GetIt with a mock UserStatusService
    profileService = MockProfileService();
    getIt.registerSingleton(profileService as ProfileService);
    getIt.registerSingleton(UserStatusService(profileService));
  });

  test('When logged in the user is redirected to complete_profile', () async {
    // Setup mock to return a UserStatus indicating the user is not authenticated
    profileService.profile = const Profile();

    final mockGoRouterState = MockGoRouterState();
    when(mockGoRouterState.fullPath).thenReturn("/");

    // Assert that the redirect function returns the login path
    expect(await authRoutes.redirect!(MockBuildContext(), mockGoRouterState),
        "/complete_profile/name");

    profileService.profile = const Profile(firstName: "John");
    expect(await authRoutes.redirect!(MockBuildContext(), mockGoRouterState),
        "/complete_profile/birthdate");
  });
}
