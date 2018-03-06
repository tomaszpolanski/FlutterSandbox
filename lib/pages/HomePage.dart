import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_view/components/HeroIcon.dart';
import 'package:flutter_view/routing/Routes.dart';

class HomePage extends StatelessWidget {
  
  final List<ExamplePage> _pages = [
    new ExamplePage("Qr Codes", Routes.kQrCodesPage,
        description: "Reading QR Codes"),
  ];

  final Tween<Offset> _kBottomUpTween = new Tween<Offset>(
    begin: const Offset(0.0, 1.0),
    end: Offset.zero,
  );

  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) =>
      new SlideTransition(
          position: _kBottomUpTween.animate(
            new CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child);

  Widget _buildListTile(BuildContext context, ExamplePage page) {
    return new MergeSemantics(
      child: new Card(
        child: new ListTile(
          title: new Text(page.title),
          subtitle: new Text(page.description),
          leading: new HeroIcon(Icons.add_a_photo),
          onTap: () {
            if (Theme.of(context).platform == TargetPlatform.android) {
              Routes.router.navigateTo(context, page.route,
                  transition: TransitionType.custom, transitionBuilder: buildTransitions,
                  transitionDuration: const Duration(milliseconds: 500));
            } else {
              Routes.router.navigateTo(context, page.route,
                  transition: TransitionType.native);
            }

          },
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Home'),
      ),

      body: new Scrollbar(
        child: new ListView(
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          children: _pages.map((page) => _buildListTile(context, page)).toList(),
        ),
      ),
    );
  }
}

class ExamplePage {
  ExamplePage(this.title, this.route, {this.description});
  
  final String title;
  final String route;
  final String description;
}
