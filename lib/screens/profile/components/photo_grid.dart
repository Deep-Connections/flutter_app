import 'package:cached_network_image/cached_network_image.dart';
import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/profile/picture/picture.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';

class PhotoGrid extends StatefulWidget {
  final List<Picture> photoUrls;
  final void Function(List<Picture>) submitNewPhotos;

  const PhotoGrid({
    super.key,
    required this.photoUrls,
    required this.submitNewPhotos,
  });

  @override
  State<PhotoGrid> createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  late final List<Picture> _photoUrls = [];
  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();

  _initialize() {
    _photoUrls
      ..clear()
      ..addAll(widget.photoUrls);
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void didUpdateWidget(covariant PhotoGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.photoUrls != widget.photoUrls) {
      _initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(standardPadding),
        child: ReorderableBuilder(
          scrollController: _scrollController,
          onReorder: (List<OrderUpdateEntity> orderUpdateEntities) {
            for (final orderUpdateEntity in orderUpdateEntities) {
              final photo = _photoUrls.removeAt(orderUpdateEntity.oldIndex);
              _photoUrls.insert(orderUpdateEntity.newIndex, photo);
              widget.submitNewPhotos(_photoUrls);
            }
          },
          builder: (children) {
            return GridView(
              key: _gridViewKey,
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: standardPadding,
                crossAxisSpacing: standardPadding,
              ),
              children: children,
            );
          },
          children: _photoUrls
              .mapNotNull((p) => p.url)
              .map((p) => CachedNetworkImage(
                    key: Key(p),
                    imageUrl: p,
                    fit: BoxFit.fill,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
