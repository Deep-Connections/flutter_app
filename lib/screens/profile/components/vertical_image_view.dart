import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VerticalImageView extends StatelessWidget {
  final List<String>? imageUrls;

  const VerticalImageView({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.width, // Maintains a 16:9 aspect ratio
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls?.length ?? 0,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: imageUrls![index],
            width: index == 0 ? 0 : MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          );
        },
      ),
    );
    ;
  }
}
