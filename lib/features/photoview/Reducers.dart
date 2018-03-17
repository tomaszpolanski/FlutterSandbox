import 'dart:async';
import 'dart:convert';

import 'package:flutter_view/features/photoview/PhotoActions.dart';
import 'package:flutter_view/state/AppState.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';


final imagesReducer = combineTypedReducers<List<String>>([
  new ReducerBinding<List<String>, FetchResultImagesAction>(_fetchImages),
]);

List<String> _fetchImages(List<String> oldImages,
    FetchResultImagesAction action) {
  List<String> list = new List();
  if (oldImages != null) list.addAll(oldImages);
  list.addAll(action.images);
  return list;
}


final currentPageReducer = combineTypedReducers<int>([
  new ReducerBinding<int, FetchResultImagesAction>(_changeCurrentPage),
]);

int _changeCurrentPage(int oldPage, FetchResultImagesAction action) =>
    action.page;


final allEpics = combineEpics<AppState>([imageFetchEpic]);

Stream<dynamic> imageFetchEpic(Stream<dynamic> actions,
    EpicStore<AppState> store) {
  return new Observable(actions)
      .ofType(new TypeToken<FetchImagesAction>())
  .distinct( )
      .flatMap((FetchImagesAction requestAction) {
    print("Fetching ${requestAction.page}");
    return fetchImages(requestAction.page)
        .map((images) =>
    new FetchResultImagesAction(images, requestAction.page))
        .takeUntil(
        actions.where((action) => action is CancelFetchImagesAction));
  });
}


Observable<List<String>> fetchImages(int page) {
  return new Observable.fromFuture(http.get(
      'https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=&text=puppy&format=json&nojsoncallback=1&per_page=300&page=$page'))
      .map((response) => JSON.decode(response.body))
      .map((json) =>
      json['photos']['photo']
          .map((photo) => new SearchResult.fromJson(photo))
          .map((result) => result.imageUrl)
          .toList());
}

class SearchResult {
  final String id;
  final String secret;
  final String title;
  final String server;
  final int farm;

  SearchResult({this.id, this.secret, this.title, this.server, this.farm});

  String get imageUrl =>
      "https://farm$farm.staticflickr.com/$server/${id}_${secret}_q.jpg";

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return new SearchResult(
      id: json['id'],
      secret: json['secret'],
      server: json['server'],
      title: json['title'],
      farm: json['farm'],
    );
  }
}



