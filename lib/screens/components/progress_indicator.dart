import 'package:flutter/material.dart';

class DcProgressIndicator extends StatelessWidget {
  const DcProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

class CenteredProgressIndicator extends StatelessWidget {
  const CenteredProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
