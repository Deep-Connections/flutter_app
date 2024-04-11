import 'dart:async';

import 'package:flutter/cupertino.dart';

class FutureOrBuilder<T> extends StatelessWidget {
  final FutureOr<T> futureOr;
  final Widget Function(BuildContext, T?) builder;

  const FutureOrBuilder(
      {super.key, required this.futureOr, required this.builder});

  @override
  Widget build(BuildContext context) {
    if (futureOr is Future<T>) {
      return FutureBuilder<T>(
        future: futureOr as Future<T>,
        builder: (context, snapshot) {
          return builder(context, snapshot.data);
        },
      );
    } else {
      return builder(context, futureOr as T);
    }
  }
}
