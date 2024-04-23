import 'package:deep_connections/config/theme.dart';
import 'package:flutter/material.dart';

class NoImageIcon extends StatelessWidget {
  final double? size;

  const NoImageIcon({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: DcColors.grey,
      ),
      child: Icon(
          size: size,
          Icons.person,
          color: Theme.of(context).colorScheme.surface),
    );
  }
}
