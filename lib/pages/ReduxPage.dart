import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_view/components/HeroIcon.dart';
import 'package:flutter_view/state/Actions.dart';
import 'package:flutter_view/state/AppState.dart';
import 'package:redux/redux.dart';

class ReduxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreBuilder(
      builder: (context, Store<AppState> store) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("Redux"),
          ),
          body: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('You have pushed the button this many times:'),
                new Text(
                  '${store.state.counter}',
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: () {
              store.dispatch(new IncrementCounterAction());
            },
            tooltip: 'Increment',
            child: new HeroIcon(Icons.redo),
          ),
        );
      },
    );
  }
}
