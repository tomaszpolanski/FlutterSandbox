import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_view/routing/Routes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: () {
            Routes.router.navigateTo(context, Routes.kQrCodesPage,
                transition: TransitionType.native);
          },
        child: new Icon(Icons.photo),
      ),
    );
  }
}


