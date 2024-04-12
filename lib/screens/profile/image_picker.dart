import 'dart:io';

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
  late String? url = widget.profileService.profile?.pictures?.lastOrNull;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final resultUrl = await ImagePicker()
            .pickImage(source: ImageSource.gallery)
            .then((image) async => await image?.path
                .let((path) => widget.profileService.uploadImage(File(path))));
        if (resultUrl != null) {
          setState(() => url = resultUrl);
        }
      },
      child: AvatarImage(size: 50, imageUrl: url),
    );
  }
}
