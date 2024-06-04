import 'package:cached_network_image/cached_network_image.dart';
import 'package:deep_connections/config/theme.dart';
import 'package:deep_connections/screens/components/image/no_image_icon.dart';
import 'package:deep_connections/screens/components/progress_indicator.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  final String? imageUrl;
  final double? size;
  final bool isLoading;
  final Widget? noImageWidget;

  const AvatarImage({super.key,
    required this.imageUrl,
    this.size,
    this.isLoading = false,
    this.noImageWidget});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: DcColors.grey,
      radius: size,
      backgroundImage: imageUrl?.let((it) => CachedNetworkImageProvider(it)),
      child: isLoading
          ? const DcProgressIndicator()
          : imageUrl == null
              ? noImageWidget ?? NoImageIcon(size: size)
              : null,
    );
  }
}
