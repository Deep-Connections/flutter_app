import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/screens/components/image/avatar_image.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/services/utils/error_handling.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class AvatarImagePicker extends StatefulWidget {
  final ProfileService profileService;

  const AvatarImagePicker({super.key, required this.profileService});

  @override
  State<AvatarImagePicker> createState() => _AvatarImagePickerState();
}

class _AvatarImagePickerState extends State<AvatarImagePicker> {
  bool isLoading = false;
  String? url;

  void _pickImage(AppLocalizations loc) => ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: imageCompression)
      .then((image) async => await image?.let((path) async {
            setState(() {
              isLoading = true;
            });

            final response = await widget.profileService
                .uploadPicture(await image.readAsBytes(), image.mimeType);
            setState(() {
              response.onSuccess((picture) => url = picture.url).onFailure(
                  (failure) => MessageHandler.showResponseError(response, loc));
              isLoading = false;
            });
          }));

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () => _pickImage(loc),
      child: AvatarImage(
        size: 75,
        imageUrl: url ?? widget.profileService.profile?.profilePicture?.url,
        isLoading: isLoading,
      ),
    );
  }
}
