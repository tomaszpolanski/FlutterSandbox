import 'package:flutter/material.dart';
import 'package:flutter_view/features/silvers/pages/AdvanceDemo.dart';
import 'package:flutter_view/features/silvers/pages/Definition.dart';
import 'package:flutter_view/features/silvers/pages/ImplementingHeader.dart';
import 'package:flutter_view/features/silvers/pages/SimpleDemo.dart';
import 'package:flutter_view/features/silvers/pages/SliverTypesPage.dart';
import 'package:flutter_view/features/silvers/pages/Thanks.dart';
import 'package:flutter_view/features/silvers/pages/TitlePage.dart';
import 'package:flutter_view/features/silvers/pages/WhatIsSliver.dart';

class SliverPresentationPage extends StatefulWidget {
  @override
  _SliverPresentationPageState createState() =>
      new _SliverPresentationPageState();
}

class _SliverPresentationPageState extends State<SliverPresentationPage> {

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
            new Definition(),
            new WhatIsSliver(),
            new SliverTypesPage(),
            new SimpleDemo(),
            new ImplementingHeader(),
            new AdvanceDemo(),
            new Thanks(),
          ]),
        ),
      ),
    );
  }
}
