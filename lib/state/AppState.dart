import 'package:flutter_view/state/Actions.dart';
import 'package:redux/redux.dart';

class AppState {
  final int counter;

  AppState({
    this.counter = 0,
  });

  AppState copyWith({int counter}) => new AppState(counter: counter ?? this.counter);
}

AppState appStateReducer(AppState state, dynamic action) {
  return new AppState(
    counter: counterReducer(state.counter, action),
  );
}

final counterReducer = combineTypedReducers<int>([
  new ReducerBinding<int, IncrementCounterAction>(_incrementCounter),
]);

int _incrementCounter(int oldCounter, action) {
  return oldCounter + 1;
}