import 'package:cached_network_image/cached_network_image.dart';
import 'package:deep_connections/models/profile/picture/picture.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';

class PhotoGrid extends StatefulWidget {
  final List<Picture> photoUrls;

  const PhotoGrid({super.key, required this.photoUrls});

  @override
  State<PhotoGrid> createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
      children: widget.photoUrls
          .mapNotNull((p) => p.url)
          .map((photo) => CachedNetworkImage(imageUrl: photo))
          .toList(),
    );
  }
}
