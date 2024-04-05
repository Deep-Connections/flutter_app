import 'package:flutter/material.dart';

class GenericStreamBuilder<T> extends StatelessWidget {
  final Stream<T> data;
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return builder(context, snapshot.data as T);
        } else {
          return const Center(child: Text('No data'));
        }
      },
    );
  }
}
