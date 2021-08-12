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

class CounterNotifier extends ChangeNotifier {
  final _Counter _counter;

  CounterNotifier(_Counter counter) : _counter = counter;

  int get count => _counter.count;
  void increment() {
    _counter.increment();
    notifyListeners();
  }
}
