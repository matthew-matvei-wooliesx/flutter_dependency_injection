import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

abstract class _Counter {
  int get count;
  void increment();
}

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
