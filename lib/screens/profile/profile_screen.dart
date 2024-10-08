import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/navigation/profile_section.dart';
import 'package:deep_connections/navigation/route_constants.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/image/avatar_image.dart';
import 'package:deep_connections/screens/profile/components/complete_profile_card.dart';
import 'package:deep_connections/services/auth/auth_service.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/user/user_status_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService authService;
  final ProfileService profileService;
  final UserStatusService userStatusService;

  const ProfileScreen(
      {super.key,
      required this.authService,
      required this.profileService,
      required this.userStatusService});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
        title: loc.profile_title,
        actions: [
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => context.go(ProfileRoutes.settings.fullPath))
        ],
        body: ListView(
          padding: const EdgeInsets.all(standardPadding),
          children: [
            Center(
                child: GestureDetector(
                    onTap: () => context.go(ProfileRoutes.photos.fullPath),
                    child: AvatarImage(
                      size: 75,
                      imageUrl: profileService.profile?.mainPictureUrl,
                    ))),
            if (profileService.profile?.mainPictureUrl == null)
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: standardPadding),
                child: ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: () => context.go(ProfileRoutes.photos.fullPath),
                    label: Text(loc.profile_addPhoto)),
              )),
            const CompleteProfileCard(),
            ...ProfileSection.values.map((section) => ListTile(
                title: Text(section.title.localize(loc),
                    style: Theme.of(context).textTheme.headlineSmall),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => context
                    .go("${ProfileRoutes.section.fullPath}/${section.path}")))
          ],
        ));
  }
}
