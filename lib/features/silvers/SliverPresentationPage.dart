import 'package:flutter/material.dart';
import 'package:flutter_view/features/silvers/pages/SliverTypesPage.dart';
import 'package:flutter_view/features/silvers/pages/TitlePage.dart';

class SliverPresentationPage extends StatefulWidget {
  @override
  _SliverPresentationPageState createState() =>
      new _SliverPresentationPageState();
}

class _SliverPresentationPageState extends State<SliverPresentationPage> {
  final PageController _detailsPageController = new PageController();

//  @override
//  Widget build(BuildContext context) {
//    return  new SafeArea(
//      child: new PageView(
//        controller: _detailsPageController,
//        children: [
//          new TitlePage(),
//          new SliverTypesPage(),
//        ]
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
            ];
          },
          body: new PageView(children: [
            new TitlePage(),
            new SliverTypesPage(),
          ]),
        ),
      ),
    );
  }
}
