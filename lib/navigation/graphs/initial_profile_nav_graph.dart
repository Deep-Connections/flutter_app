import 'package:deep_connections/config/injectable/injectable.dart';
import 'package:deep_connections/config/profile_step_list.dart';
import 'package:deep_connections/models/user/user_status.dart';
import 'package:deep_connections/navigation/generate_profile_step_graph.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/services/chat/chat_service.dart';
import 'package:deep_connections/services/user/user_status_service.dart';
import 'package:deep_connections/services/utils/error_handling.dart';
import 'package:go_router/go_router.dart';

final initialProfileRoutes = GoRoute(
  path: InitialProfileRoutes.main.path,
  redirect: (context, state) async {
    final UserStatus userStatus = await getIt<UserStatusService>().userStatus;
    if (userStatus.isProfileComplete) {
      return homeRoute;
    }
    if (state.fullPath == InitialProfileRoutes.main.fullPath) {
      return userStatus.uncompletedStep
              ?.navigationFromBasePath(InitialProfileRoutes.main.fullPath) ??
          homeRoute;
    }
    return null;
  },
  routes: generateProfileStepGraph(
    initialProfileStepList,
    InitialProfileRoutes.main.fullPath,
    onFinishProfile: (profile) async {
      if (profile.numMatches == null) {
        MessageHandler.showResponseError(
            await getIt<ChatService>().createMatch());
      }
    },
  ),
);
