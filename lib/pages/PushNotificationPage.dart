import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_view/components/HeroIcon.dart';


class PushNotificationPage extends StatefulWidget {
  @override
  _PushNotificationPageState createState() => new _PushNotificationPageState();
}

class _PushNotificationPageState extends State<PushNotificationPage> {

  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  String _message;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging..configure(
      onMessage: (Map<String, dynamic> message) {
        setState(() {
          _message = message.values.first;
        });
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) {
        print("onResume: $message");
      },
    )..getToken().then((String token) {
      assert(token != null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Push notification'),
      ),
      body: new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new HeroIcon(Icons.notifications),
            new SizedBox(width: 10.0),
            new Text(_message ?? "No messages yet..."),
          ],
        ),
      ),
    );
  }
}
