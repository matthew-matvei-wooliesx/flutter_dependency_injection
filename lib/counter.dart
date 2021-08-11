import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides a [_CounterNotifier].
///
/// _PoC note:_ this literally provides the UI access to our [_CounterNotifier],
/// which forms a thin wrapper around its injected [_Counter]. While we don't
/// get dependency resolution completely by magic, this does make behaviour
/// loosely coupled with the UI, since we can easily modify the implementation
/// here to read [_doubleStepCounterProvider] instead.
///
/// From a dependency injection perspective then, we can see [_Counter] and
/// [_SingleStepCounter] as abstraction and implementation respectively, where
/// providers such as this one define how we manage our dependencies.
final counterNotifierProvider = ChangeNotifierProvider<_CounterNotifier>((ref) {
  final counter = ref.read(_singleStepCounterProvider);

  return _CounterNotifier(counter);
});

final _singleStepCounterProvider = Provider((ref) => _SingleStepCounter());
final _doubleStepCounterProvider = Provider((ref) => _DoubleStepCounter());

class _CounterNotifier extends ChangeNotifier {
  final _Counter _counter;

  _CounterNotifier(_Counter counter) : _counter = counter;

  int get count => _counter.count;
  void increment() {
    _counter.increment();
    notifyListeners();
  }
}

/// Defines basic counter functionality.
///
/// _PoC note:_ This can be seen as an abstraction of domain-level logic (i.e.
/// 'business rules'), so this serves as an example of where we want to inject
/// complex objects that aren't coupled to the UI.
abstract class _Counter {
  int get count;
  void increment();
}

/// Defines a [_Counter] with a step equal to 1.
class _SingleStepCounter implements _Counter {
  int _count = 0;
  final int step = 1;

  @override
  int get count => _count;

  @override
  void increment() {
    _count += step;
  }
}

/// Defines a [_Counter] with a step equal to 2.
class _DoubleStepCounter implements _Counter {
  int _count = 0;
  final int step = 2;

  @override
  int get count => _count;

  @override
  void increment() {
    _count += step;
  }
}
