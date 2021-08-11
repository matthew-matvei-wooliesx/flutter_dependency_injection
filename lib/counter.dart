import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class Counter {
  int get count;
  void increment();
}

final _singleStepCounterProvider = Provider((ref) => _SingleStepCounter());
final _doubleStepCounterProvider = Provider((ref) => _DoubleStepCounter());
final counterNotifierProvider = ChangeNotifierProvider<_CounterNotifier>((ref) {
  final counter = ref.read(_singleStepCounterProvider);

  return _CounterNotifier(counter);
});

class _CounterNotifier extends ChangeNotifier {
  final Counter _counter;

  _CounterNotifier(Counter counter) : _counter = counter;

  int get count => _counter.count;
  void increment() {
    _counter.increment();
    notifyListeners();
  }
}

class _SingleStepCounter implements Counter {
  int _count = 0;
  final int step = 1;

  @override
  int get count => _count;

  @override
  void increment() {
    _count += step;
  }
}

class _DoubleStepCounter implements Counter {
  int _count = 0;
  final int step = 2;

  @override
  int get count => _count;

  @override
  void increment() {
    _count += step;
  }
}
