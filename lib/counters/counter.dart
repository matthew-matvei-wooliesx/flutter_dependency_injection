/// _PoC note:_ this library houses domain-level logic that, while it will
/// ultimately serve a purpose in the UI, should be loosely coupled with any
/// UI concerns. This is why 'providers.dart' remains a separate library, which
/// should only thinly wrap more complex functionality that 'counter.dart'
/// provides. Classes here can also be tested in isolation regardless of what
/// framework we wrap them with for state / dependency management.
library counters.counter;

import 'package:flutter/foundation.dart';

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
class SingleStepCounter implements _Counter {
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
class DoubleStepCounter implements _Counter {
  int _count = 0;
  final int step = 2;

  @override
  int get count => _count;

  @override
  void increment() {
    _count += step;
  }
}

/// A [ChangeNotifier] that notifies listeners when a [_Counter] is incremented.
///
/// _PoC note:_ this one's a tough one. Since this class only exists to integrate
/// with Riverpod's 'ChangeNotifierProvider', it seems to belong in 'providers.dart'
/// along with the other Riverpod-related objects. However, in a hypothetical
/// refactor to another state management framework, it's foreseeable that this
/// same 'ChangeNotifier' could be wrapped by the replacement framework.
class CounterNotifier extends ChangeNotifier {
  final _Counter _counter;

  CounterNotifier(_Counter counter) : _counter = counter;

  int get count => _counter.count;
  void increment() {
    _counter.increment();
    notifyListeners();
  }
}
