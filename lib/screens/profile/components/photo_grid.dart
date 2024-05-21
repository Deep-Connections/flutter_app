import 'package:cached_network_image/cached_network_image.dart';
import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/profile/picture/picture.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';

const maxNumberOfPhotos = 6;

class PhotoGrid extends StatefulWidget {
  final List<Picture> photoUrls;
  final void Function(List<Picture>) submitNewPhotos;
  final void Function() addPhoto;

  const PhotoGrid({
    super.key,
    required this.photoUrls,
    required this.submitNewPhotos,
    required this.addPhoto,
  });

  @override
  State<PhotoGrid> createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  late final List<Picture?> _photoUrls = [];
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
    final numMissingPhotos = maxNumberOfPhotos - _photoUrls.length;
    final photoUrlsAndNull = _photoUrls + List.filled(numMissingPhotos, null);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(standardPadding),
        child: ReorderableBuilder(
          scrollController: _scrollController,
          dragChildBoxDecoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 8.0,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          onReorder: (List<OrderUpdateEntity> orderUpdateEntities) {
            for (final orderUpdateEntity in orderUpdateEntities) {
              final photo = _photoUrls.removeAt(orderUpdateEntity.oldIndex);
              _photoUrls.insert(orderUpdateEntity.newIndex, photo);
              final newPhotos = _photoUrls.mapNotNull((e) => e).toList();
              if (newPhotos.isNotEmpty) {
                widget.submitNewPhotos(newPhotos);
              }
            }
          },
          lockedIndices: List.generate(
              numMissingPhotos, (index) => _photoUrls.length + index),
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
          children: photoUrlsAndNull
              .mapIndexed((index, photo) {
                if (photo == null || photo.url?.isEmpty == true) {
                  return GestureDetector(
                    key: Key(index.toString()),
                    onTap: widget.addPhoto,
                    child: Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.add),
                    ),
                  );
                } else {
                  final url = photo.url!;
                  return CachedNetworkImage(
                    key: Key(url),
                    imageUrl: url,
                    fit: BoxFit.cover,
                  );
                }
              })
              .map((child) => ClipRRect(
                  key: child.key,
                  borderRadius: BorderRadius.circular(8.0),
                  child: child))
              .toList(),
        ),
      ),
    );
  }
}
