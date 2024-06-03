import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/components/base_screen.dart';
import 'package:deep_connections/screens/components/stream_builder.dart';
import 'package:deep_connections/screens/profile/components/photo_grid.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/utils/error_handling.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhotoScreen extends StatelessWidget {
  final ProfileService profileService;

  const ProfilePhotoScreen({super.key, required this.profileService});

  void _pickImage() => ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: imageCompression)
      .then((image) async => await image?.let((path) async {
            /* setState(() {
               isLoading = true;
             });*/

            final response = await profileService.uploadPicture(
                await image.readAsBytes(), image.mimeType);
            response.onFailure(
                (failure) => MessageHandler.showResponseError(response));
            /*setState(() {
            isLoading = false;
            });*/
          }));

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BaseScreen(
        title: loc.profilePhotos_title,
        body: GenericStreamBuilder(
          data: profileService.profileStream,
          builder: (BuildContext context, Profile profile) {
            return PhotoGrid(
              pictures: profile.pictures ?? [],
              submitNewPhotos: (newPhotos) {
                profileService.updateProfile(
                    (profile) => profile.copyWith(pictures: newPhotos));
              },
              addPicture: () => _pickImage(),
              deletePicture: (picture) async =>
                  MessageHandler.showResponseError(
                      await profileService.deletePicture(picture)),
            );
          },
        ));
  }
}
