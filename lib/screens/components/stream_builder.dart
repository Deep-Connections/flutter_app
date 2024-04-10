import 'package:deep_connections/screens/components/progress_indicator.dart';
import 'package:flutter/material.dart';

class GenericStreamBuilder<T> extends StatelessWidget {
  final Stream<T?> data;
  final Widget Function(BuildContext context, T data) builder;

  const GenericStreamBuilder({
    Key? key,
    required this.data,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return const Center(child: DcProgressIndicator());
        } else if (snapshot.hasError) {
          return SnapshotError(error: snapshot.error);
        } else if (snapshot.hasData) {
          return builder(context, snapshot.data as T);
        } else {
          return const Center(child: Text('No data'));
        }
      },
    );
  }
}

class EmptyStreamBuilder<T> extends StatelessWidget {
  final Stream<T?> data;
  final Widget Function(BuildContext context, T data) builder;

  const EmptyStreamBuilder({
    Key? key,
    required this.data,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: data,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SnapshotError(error: snapshot.error);
        } else if (snapshot.hasData) {
          return builder(context, snapshot.data as T);
        }
        return const SizedBox();
      },
    );
  }
}

class SnapshotError extends StatelessWidget {
  final Object? error;

  const SnapshotError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Error: $error'));
  }
}
