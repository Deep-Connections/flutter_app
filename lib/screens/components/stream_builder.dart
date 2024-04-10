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
            (snapshot.hasData && snapshot.data == null)) {
          return const Center(child: ProgressIndicator());
        } else if (snapshot.hasError) {
          return _StreamError(error: snapshot.error);
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
        if (snapshot.connectionState == ConnectionState.waiting ||
            (snapshot.hasData && snapshot.data == null)) {
          return const SizedBox();
        } else if (snapshot.hasError) {
          return _StreamError(error: snapshot.error);
        } else if (snapshot.hasData) {
          return builder(context, snapshot.data as T);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _StreamError extends StatelessWidget {
  final Object? error;

  const _StreamError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Error: $error'));
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
