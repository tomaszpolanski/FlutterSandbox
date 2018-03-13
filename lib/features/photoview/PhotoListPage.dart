

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_view/features/photoview/PhotoActions.dart';
import 'package:flutter_view/state/AppState.dart';

import 'package:redux/redux.dart';

class PhotoListPage extends StatefulWidget {
  @override
  _PhotoListPageState createState() => new _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {

  final ScrollController scrollController = new ScrollController();
  int currentPage = 1;


  @override
  Widget build(BuildContext context) {
    return new StoreBuilder(
      onInit: (store) {
        if (store.state.images == null) {
          store.dispatch(new FetchImagesAction(store.state.currentPage + 1));
        }
      },
      onDispose: (store) => store.dispatch(new CancelFetchImagesAction()),
      builder: (context, Store<AppState> store) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Puppies ${store.state.currentPage}!'),
          ),
          body: new GridView.builder(
            controller: scrollController,
            itemCount: store.state.images == null ? 0 : store.state.images .length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (store.state.images.length - index == 50) {
                store.dispatch(new FetchImagesAction(store.state.currentPage + 1));
              }
              return new CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: store.state.images[index],
                placeholder: new Container(
                    padding: const EdgeInsets.all(20.0),
                    child: new CircularProgressIndicator(
                      strokeWidth: 16.0,
                    )),
                errorWidget: new Icon(Icons.error),
              );
            },
          ),
        );
      },
    );
  }
}


