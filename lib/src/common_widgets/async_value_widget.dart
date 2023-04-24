import 'dart:developer' as developer;

import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
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
        developer.log('Error: ${e.toString()}\nStack Trace: $st',
            name: 'logs.error', error: e);
        return const NotFound();
      },
      loading: () => Center(
          child: showLoading ? const CircularProgressIndicator() : Container()),
    );
  }
}
