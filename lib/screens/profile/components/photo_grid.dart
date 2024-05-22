import 'package:cached_network_image/cached_network_image.dart';
import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/models/profile/picture/picture.dart';
import 'package:deep_connections/screens/components/dialogs/confirmation_dialog.dart';
import 'package:deep_connections/utils/extensions/general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';

const maxNumPhotos = 6;

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
  final List<Picture?> _photoUrls = [];
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

  _submitPhotos() {
    final newPhotos = _photoUrls.mapNotNull((e) => e).toList();
    if (newPhotos.isNotEmpty) {
      widget.submitNewPhotos(newPhotos);
    }
  }

  @override
  Widget build(BuildContext context) {
    final numMissingPhotos = maxNumPhotos - _photoUrls.length;
    final photoUrlsAndNull = _photoUrls + List.filled(numMissingPhotos, null);
    final colorScheme = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(standardPadding),
        child: ReorderableBuilder(
          scrollController: _scrollController,
          dragChildBoxDecoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: colorScheme.onBackground.withOpacity(0.2),
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
              _submitPhotos();
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
                      color: colorScheme.surface,
                      child: Icon(Icons.add, color: colorScheme.onSurface),
                    ),
                  );
                } else {
                  final url = photo.url!;
                  return PhotoItem(
                      key: Key(url),
                      url: url,
                      onDelete: () {
                        setState(() {
                          _photoUrls.removeAt(index);
                          //_submitPhotos();
                        });
                      });
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

class PhotoItem extends StatelessWidget {
  final String url;
  final void Function() onDelete;

  const PhotoItem({super.key, required this.url, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(colorScheme.surface),
            ),
            icon: Icon(Icons.delete, color: colorScheme.onSurface),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ConfirmationDialog(
                        context: context,
                        titleText: loc.profilePhotos_deleteTitle,
                        contentText: loc.profilePhotos_deleteContent,
                        confirmText: loc.general_delete,
                        onConfirm: onDelete);
                  });
            },
          ),
        )
      ],
    );
  }
}
