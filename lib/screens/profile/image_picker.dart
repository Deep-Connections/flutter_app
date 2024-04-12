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
  bool isLoading = false;

  _uploadImage(File file) async {
    setState(() => isLoading = true);
    String? resultUrl;
    try {
      resultUrl = await widget.profileService.uploadImage(file);
    } finally {
      setState(() {
        if (resultUrl != null) url = resultUrl;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isLoading
          ? () => ImagePicker()
              .pickImage(source: ImageSource.gallery, imageQuality: 70)
              .then((image) =>
                  image?.path.let((path) => _uploadImage(File(path))))
          : null,
      child: AvatarImage(size: 50, imageUrl: url, isLoading: isLoading),
    );
  }
}
