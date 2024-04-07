import 'package:deep_connections/config/constants.dart';
import 'package:deep_connections/screens/components/dc_column.dart';
import 'package:flutter/cupertino.dart';

class DcListView extends StatelessWidget {
  final List<Widget> children;
  final double space;

  const DcListView(
      {super.key, required this.children, this.space = BASE_PADDING});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: spaceChildren(children, space),
    );
  }
}
