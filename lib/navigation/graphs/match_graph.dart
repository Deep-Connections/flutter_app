import 'package:deep_connections/config/injectable/injectable.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/chat/match_profile_screen.dart';
import 'package:deep_connections/screens/chat/message_list_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final matchGraph = GoRoute(
    path: MainRoutes.match.path,
    builder: (context, state) {
      if (state.fullPath == MainRoutes.match.fullPath) {
        context.go(BottomNavigation.chat.fullPath);
      }
      return const SizedBox();
    },
    routes: [
      GoRoute(
          path: MainRoutes.messages.path,
          redirect: (context, state) {
            final chatId =
                state.pathParameters[MainRoutes.messages.pathParameter];
            if (chatId == null || chatId == "") {
              return BottomNavigation.chat.fullPath;
            }
            return null;
          },
          builder: (context, state) {
            final chatId =
                state.pathParameters[MainRoutes.messages.pathParameter];
            return MessageListScreen(
                chatId: chatId!, chatService: getIt(), profileService: getIt());
          },
          routes: [
            GoRoute(
                path: MainRoutes.matchProfile.path,
                builder: (context, state) {
                  final chatId =
                      state.pathParameters[MainRoutes.messages.pathParameter];
                  return MatchProfileScreen(
                      chatId: chatId!,
                      chatService: getIt(),
                      profileService: getIt());
                })
          ]),
    ]);
