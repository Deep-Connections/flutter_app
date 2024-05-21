import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/stream_builder.dart';
import 'package:deep_connections/screens/profile/components/photo_grid.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePhotoScreen extends StatelessWidget {
  final ProfileService profileService;

  const ProfilePhotoScreen({super.key, required this.profileService});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
        title: loc.profilePhotos_title,
        body: GenericStreamBuilder(
          data: profileService.profileStream,
          builder: (BuildContext context, Profile profile) {
            return PhotoGrid(
                photoUrls: profile.pictures ?? [],
                submitNewPhotos: (newPhotos) {
                  profileService.updateProfile(
                      (profile) => profile.copyWith(pictures: newPhotos));
                });
          },
        ));
  }
}
