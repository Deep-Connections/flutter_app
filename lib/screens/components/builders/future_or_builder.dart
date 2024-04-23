import 'dart:async';

import 'package:flutter/cupertino.dart';

class FutureOrBuilder<T> extends StatelessWidget {
  final FutureOr<T>? futureOr;
  final Widget Function(
      BuildContext context, T? data, FutureOrSnapshot<T> snapshot) builder;

  const FutureOrBuilder(
      {super.key, required this.futureOr, required this.builder});

  @override
  Widget build(BuildContext context) {
    if (futureOr is Future<T>) {
      return FutureBuilder<T>(
        future: futureOr as Future<T>,
        builder: (context, snapshot) {
          final data = snapshot.data;
          return builder(context, data, FutureOrSnapshot(data, snapshot));
        },
      );
    } else {
      final data = futureOr as T?;
      return builder(context, data, FutureOrSnapshot(data, null));
    }
  }
}

class FutureOrSnapshot<T> {
  final T? _data;
  final AsyncSnapshot<T>? _async;

  const FutureOrSnapshot(this._data, this._async);

  bool get loading =>
      _async != null && _async.connectionState == ConnectionState.waiting;

  bool get completed =>
      _async == null || _async.connectionState == ConnectionState.done;
}
