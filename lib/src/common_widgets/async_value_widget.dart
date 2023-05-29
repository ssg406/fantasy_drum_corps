import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget(
      {super.key,
      required this.value,
      required this.data,
      this.showLoading = true});

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) {
        debugPrint('Error: ${e.toString()}\n$st');
        return Center(
          child: Text(
            'Internal Server Error',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      },
      loading: () => Center(
          child: showLoading ? const CircularProgressIndicator() : Container()),
    );
  }
}
