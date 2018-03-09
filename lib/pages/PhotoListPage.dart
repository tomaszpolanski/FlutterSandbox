import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class PhotoListPage extends StatefulWidget {
  @override
  _PhotoListPageState createState() => new _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {

  List<String> images = new List();
  final ScrollController scrollController = new ScrollController();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();

    _loadImages();
  }

  void _loadImages() {
    test(currentPage++)
        .listen((data) => setState(() {
      images.addAll(data);
    }));
  }

  Observable<List<String>> test(int page) {
    return new Observable.fromFuture(http.get(
        'https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=29372f5b6da70b4268fdb8b154207b39&text=puppy&format=json&nojsoncallback=1&page=$page'))
        .map((response) => JSON.decode(response.body))
        .map((json) =>
        json['photos']['photo']
            .map((photo) => new SearchResult.fromJson(photo))
            .map((result) => result.imageUrl)
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Push notification'),
      ),
      body: new GridView.builder(
        controller: scrollController,
        itemCount: images.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (images.length - index == 50) {
            _loadImages();
          }
          return new CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: images[index],
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
  }
}

class Groups {
}

class SearchResult {
  final String id;
  final String secret;
  final String title;
  final String server;
  final int farm;

  SearchResult({this.id, this.secret, this.title, this.server, this.farm});

  String get imageUrl => "https://farm$farm.staticflickr.com/$server/${id}_${secret}_q.jpg";

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



