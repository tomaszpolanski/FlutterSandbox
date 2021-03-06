import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_view/pages/HomePage.dart';
import 'package:flutter_view/routing/Routes.dart';
import 'package:flutter_view/state/AppState.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_stetho/flutter_stetho.dart';


const int _kMaxEventsPerSecond = 1000;

void main() {
  HttpOverrides.global = new StethoHttpOverrides();

  runApp(new FlutterView());
}


class FlutterView extends StatelessWidget {
  final store = new Store<AppState>(
      appStateReducer,
      initialState: new AppState(),
      middleware: [new EpicMiddleware(allEpics)]
  );
  FlutterView() {
    Routes.configureRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter View',
        theme: new ThemeData(
          primarySwatch: Colors.green,
        ),
        home: new HomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.router);

  final Router router;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String _channel = 'increment';
  static const String _pong = 'pong';
  static const String _emptyMessage = '';
  static const BasicMessageChannel<String> platform =
  const BasicMessageChannel<String>(_channel, const StringCodec());

  final PublishSubject<int> subject = new PublishSubject<int>();

  int _counter = 0;

  @override
  void initState() {
    super.initState();


    platform.setMessageHandler(_handlePlatformIncrement);

    subject.stream
        .flatMapLatest((eventsPerSecond) =>
    new Stream<int>.periodic(
        new Duration(milliseconds: (1000 / eventsPerSecond).round())))
        .listen((_) {
      _sendFlutterIncrement();
    });
  }

  @override
  void dispose() {
    super.dispose();
    subject.close();
  }

  Future<String> _handlePlatformIncrement(String message) async {
    final capedCount = min(int.parse(message), _kMaxEventsPerSecond);
    subject.add(capedCount);
    setState(() {
      _counter = capedCount;
    });
    return _emptyMessage;
  }

  void _sendFlutterIncrement() {
    platform.send(_pong);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
          onPressed: () {
            widget.router.navigateTo(context, Routes.kHomePage,
                transition: TransitionType.native);
          },
        child: new Icon(Icons.open_in_new),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new Center(
                child: new Text(
                    'Trying to send $_counter event${ _counter == 1 ? '' : 's' } '
                        'per second',
                    style: const TextStyle(fontSize: 17.0))),
          ),
          new Container(
            padding: const EdgeInsets.only(bottom: 15.0, left: 5.0),
            child: new Row(
              children: <Widget>[
                new Image.asset('assets/flutter-mark-square-64.png',
                    scale: 1.5),
                const Text('Flutter', style: const TextStyle(fontSize: 30.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
