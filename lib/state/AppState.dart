import 'package:flutter_view/state/Actions.dart';
import 'package:flutter_view/features/photoview/Reducers.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

class AppState {
  final int counter;
  final int currentPage;
  final List<String> images;

  AppState({
    this.counter = 0,
    this.currentPage = 0,
    this.images = const [],
  });

  AppState copyWith({int counter, int currentPage, List<String> images}) =>
      new AppState(
        counter: counter ?? this.counter,
        currentPage: currentPage ?? this.currentPage,
        images: images ?? this.images,
      );
}

final allEpics = combineEpics<AppState>([imageFetchEpic]);

AppState appStateReducer(AppState state, dynamic action) {
  return new AppState(
      counter: counterReducer(state.counter, action),
      currentPage: currentPageReducer(state.currentPage, action),
      images: imagesReducer(state.images, action)
  );
}

final counterReducer = combineTypedReducers<int>([
  new ReducerBinding<int, IncrementCounterAction>((int oldCounter, action) => oldCounter + 1),
]);
