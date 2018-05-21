import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_view/components/HeroIcon.dart';
import 'package:flutter_view/routing/Routes.dart';

class HomePage extends StatelessWidget {
  final List<ExamplePage> _pages = [
    new ExamplePage("Sliver Presentation", Routes.kSliverPresentation, Icons.important_devices,
        description: "Let's lear about Slivers!"),
    new ExamplePage("Sliver1", Routes.kSliver1, Icons.golf_course,
        description: "Basic slivers"),
    new ExamplePage("Sliver2", Routes.kSliver2, Icons.add_circle,
        description: "Sliver usage"),
    new ExamplePage("MultiChild Layout", Routes.kQrCodesPage, Icons.add_a_photo,
        description: "Layouting some stuff"),
    new ExamplePage("Push Notifications", Routes.kPush, Icons.notifications,
        description: "Receiving push notifications"),
    new ExamplePage("Redux", Routes.kRedux, Icons.redo,
        description: "Using Redux architecture"),
    new ExamplePage("Photo List", Routes.kPhotoView, Icons.photo,
        description: "Paginated Image Example"),
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
          leading: new HeroIcon(page.icon),
          onTap: () {
            if (Theme.of(context).platform == TargetPlatform.android) {
              Routes.router.navigateTo(context, page.route,
                  transition: TransitionType.custom,
                  transitionBuilder: buildTransitions,
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
        title: const Text('Sandbox'),
      ),
      body: new Scrollbar(
        child: new ListView(
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          children:
              _pages.map((page) => _buildListTile(context, page)).toList(),
        ),
      ),
    );
  }
}

class ExamplePage {
  ExamplePage(this.title, this.route, this.icon, {this.description});

  final String title;
  final String route;
  final IconData icon;
  final String description;
}

class Test1 extends StatefulWidget {
  @override
  _Test1State createState() => new _Test1State();
}

class _Test1State extends State<Test1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}

class Main extends StatelessWidget {
  final CrossFadeState state;

  const Main({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AnimatedCrossFade(
        firstChild: new CircularProgressIndicator(),
        secondChild: new Icon(Icons.star),
        crossFadeState: state,
        duration: const Duration(seconds: 2));
  }
}
