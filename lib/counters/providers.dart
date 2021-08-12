/// _poC note:_ Separating the Riverpod Providers for counters into a separate
/// library promotes 'counter.dart' having publicly accessible (and therefore
/// more easily testable) code. If these providers were kept in the 'counter.dart'
/// library, then important classes such as 'CounterNotifier' could remain
/// private implementation details of the providers. Since the provided objects
/// should be able to stand on their own without Riverpod, this would be
/// excessive privatisation.
library counters.providers;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'counter.dart';


/// Provides a [CounterNotifier].
///
/// _PoC note:_ this literally provides the UI access to our [CounterNotifier],
/// which forms a thin wrapper around its injected counter. While we don't
/// get dependency resolution completely by magic, this does make behaviour
/// loosely coupled with the UI, since we can easily modify the implementation
/// here to read [_doubleStepCounterProvider] instead.
///
/// From a dependency injection perspective then, we can see 'Counter' and
/// [SingleStepCounter] as abstraction and implementation respectively, where
/// providers such as this one define how we manage our dependencies.
final counterNotifierProvider = ChangeNotifierProvider<CounterNotifier>((ref) {
  final counter = ref.read(_singleStepCounterProvider);

  return CounterNotifier(counter);
});

final _singleStepCounterProvider = Provider((ref) => SingleStepCounter());
final _doubleStepCounterProvider = Provider((ref) => DoubleStepCounter());
