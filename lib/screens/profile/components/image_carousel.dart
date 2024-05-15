import 'package:cached_network_image/cached_network_image.dart';
import 'package:deep_connections/models/profile/picture/picture.dart';
import 'package:deep_connections/models/profile/profile/profile.dart';
import 'package:deep_connections/screens/components/builders/future_or_builder.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:deep_connections/screens/components/progress_indicator.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:deep_connections/utils/logging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageCarousel extends StatefulWidget {
  final List<Picture>? pictures;
  final bool isLoading;

  const ImageCarousel(
      {super.key, required this.pictures, this.isLoading = false});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  List<String?> errorUrls = [];
  bool willUpdate = false;

  void delayedSetState() {
    if (willUpdate) {
      return;
    }
    willUpdate = true;
    Future.delayed(const Duration(microseconds: 1), () {
      if (mounted) {
        setState(() {
          logger.d("reset image carousel after error url");
          willUpdate = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return SizedBox(
          height: MediaQuery.of(context).size.width, // squared
          child: const Center(child: (DcProgressIndicator())));
    }
    final pictures =
        widget.pictures?.where((pic) => !errorUrls.contains(pic.url)).toList();
    if (pictures == null || pictures.isEmpty) {
      return const Spacer();
    }
    return SizedBox(
        height: MediaQuery.of(context).size.width, // squared
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: pictures.length,
          itemBuilder: (context, index) {
            return CachedNetworkImage(
              imageUrl: pictures[index].url ?? "",
              fit: BoxFit.cover,
              fadeInDuration: Duration.zero,
              errorWidget: (context, url, error) {
                errorUrls.add(url);
                delayedSetState();
                return const CenteredProgressIndicator();
              },
            );
          },
        ));
  }
}

class ProfileImageCarousel extends StatelessWidget {
  final Profile? profile;
  final FutureOrSnapshot snapshot;

  const ProfileImageCarousel(
      {super.key, required this.profile, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final profile = this.profile;
    if (snapshot.completed &&
        profile != null &&
        profile.pictures.isNullOrEmpty) {
      return NoImageWidget(profile: profile);
    } else {
      return ImageCarousel(
          pictures: profile?.pictures ?? [], isLoading: snapshot.loading);
    }
  }
}

class NoImageWidget extends StatelessWidget {
  final Profile profile;

  const NoImageWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return DcColumn(children: [
      const Icon(Icons.no_photography),
      Text(
        loc.matchProfile_noUpload(profile.firstName ?? ""),
        style: theme.textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    ]);
  }
}
