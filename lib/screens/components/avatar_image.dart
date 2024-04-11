import 'package:deep_connections/config/theme.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  final String? imageUrl;

  const AvatarImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: DcColors.grey,
      backgroundImage: imageUrl?.let((it) => NetworkImage(it)),
      child: imageUrl == null
          ? Icon(Icons.person, color: Theme.of(context).colorScheme.surface)
          : null,
    );
  }
}
