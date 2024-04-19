import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/profile/components/complete_profile_card.dart';
import 'package:deep_connections/screens/profile/components/image_picker.dart';
import 'package:deep_connections/services/auth/auth_service.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/user/user_status_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              icon: const Icon(Icons.logout), onPressed: authService.signOut)
        ],
        body: DcColumn(
          children: [
            Center(child: AvatarImagePicker(profileService: profileService)),
            StreamBuilder(
                stream: userStatusService.userStatusStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data?.isAdditionalProfileComplete == false) {
                    return const CompleteProfileCard();
                  }
                  return const Spacer();
                })
          ],
        ));
  }
}
