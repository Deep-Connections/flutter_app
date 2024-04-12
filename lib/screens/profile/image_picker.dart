import 'dart:io';

import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/screens/components/image/avatar_image.dart';
import 'package:deep_connections/services/profile/profile_service.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';
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

  void _pickImage() => ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: imageCompression)
      .then((image) async => await image?.path.let((path) async {
            setState(() {
              isLoading = true;
            });
            final response =
                await widget.profileService.uploadPicture(File(path));
            setState(() {
              response.onSuccess((picture) => url = picture.url);
              isLoading = false;
            });
          }));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: AvatarImage(
        size: 50,
        imageUrl: url ?? widget.profileService.profile?.profilePicture?.url,
        isLoading: isLoading,
      ),
    );
  }
}
