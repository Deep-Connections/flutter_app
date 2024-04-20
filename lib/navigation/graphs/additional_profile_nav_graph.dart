import 'package:deep_connections/config/injectable/injectable.dart';
import 'package:deep_connections/config/profile_step_list.dart';
import 'package:deep_connections/models/user/user_status.dart';
import 'package:deep_connections/navigation/generate_profile_step_graph.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/services/user/user_status_service.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:go_router/go_router.dart';

final additionalProfileRoutes = GoRoute(
    path: ProfileRoutes.additional.path,
    redirect: (context, state) async {
      final UserStatus userStatus = await getIt<UserStatusService>().userStatus;
      if (state.fullPath == ProfileRoutes.additional.fullPath) {
        return userStatus.additionalUncompletedStep
                ?.navigationFromBasePath(ProfileRoutes.additional.fullPath) ??
            homeRoute;
      }
      return null;
    },
    routes: generateProfileStepGraph(
        additionalProfileStepList, ProfileRoutes.additional.fullPath,
        navigateLast: (context) async => ProfileRoutes
            .additional.parent?.fullPath
            .let((path) => context.go(path))));
