import 'package:deep_connections/config/constants.dart';
import 'package:flutter/material.dart';

class DcColumn extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final EdgeInsetsGeometry padding;
  final double spacedBy;
  final List<Widget> children;

  const DcColumn({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.padding = const EdgeInsets.all(standardPadding),
    this.spacedBy = standardPadding,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: spaceChildren(children, spacedBy),
      ),
    );
  }
}

/// Add SizedBox between each child to create spacing
List<Widget> spaceChildren(List<Widget> children, double space) {
  List<Widget> spacedChildren = [];
  for (int i = 0; i < children.length; i++) {
    spacedChildren.add(children[i]);
    if (i < children.length - 1) {
      spacedChildren.add(SizedBox(height: space, width: space));
    }
  }
  return spacedChildren;
}
