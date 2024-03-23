import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/profile/gender_profile_screen.dart';
import 'package:deep_connections/screens/profile/height_profile_screen.dart';
import 'package:deep_connections/screens/profile/name_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/injectable.dart';

final profileRoutes = [
  GoRoute(
    path: ProfileRoutes.name.fullPath,
    builder: (context, state) {
      return NameProfileScreen(profileService: getIt());
    },
  ),
  GoRoute(
    path: ProfileRoutes.birthday.fullPath,
    builder: (context, state) {
      return Container();
    },
  ),
  GoRoute(
    path: ProfileRoutes.height.fullPath,
    builder: (context, state) {
      return HeightProfileScreen(profileService: getIt());
    },
  ),
  GoRoute(
      path: ProfileRoutes.gender.fullPath,
      builder: (context, state) {
        return GenderProfileScreen(profileService: getIt());
      }),
];
