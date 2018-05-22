import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';

class AdvanceDemo extends StatelessWidget {
  void _openLinkInGoogleChrome() {
    new AndroidIntent(
            action: 'android.intent.action.MAIN',
            category: 'android.intent.category.LAUNCHER',
            package: 'io.flutter.demo.gallery')
        .launch();
  }

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: _openLinkInGoogleChrome,
      child: new Text(
        'Demo time!',
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }
}
