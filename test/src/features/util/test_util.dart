import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Listener<T> extends Mock {
  void call(T? previous, T? next);
}

ProviderContainer makeProviderContainer(List<Override> overrides) {
  final container = ProviderContainer(
    overrides: overrides,
  );
  addTearDown(() => container.dispose());
  return container;
}
