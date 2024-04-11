import 'dart:async';

import 'package:flutter/cupertino.dart';

class FutureOrBuilder<T> extends StatelessWidget {
  final FutureOr<T> future;
  final Widget Function(BuildContext, T?) builder;

  const FutureOrBuilder(
      {super.key, required this.future, required this.builder});

  @override
  Widget build(BuildContext context) {
    if (future is Future<T>) {
      return FutureBuilder<T>(
        future: future as Future<T>,
        builder: (context, snapshot) {
          return builder(context, snapshot.data);
        },
      );
    } else {
      return builder(context, future as T);
    }
  }
}
