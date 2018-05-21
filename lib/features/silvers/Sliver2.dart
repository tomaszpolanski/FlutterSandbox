import 'package:flutter/material.dart';
import 'package:flutter_view/features/silvers/Bar.dart';
import 'package:flutter_view/features/silvers/CustomAppBar.dart';

class Sliver2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new CustomScrollView(
        slivers: <Widget>[
          new CustomAppBar(
            expandedHeight: 150.0,
            flexibleSpace: new Bar(
              start: Colors.red,
              end: Colors.purple,
            ),
          ),
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: new Text(
                      'list item $index',
                      style: Theme.of(context).textTheme.title,
                    ),
                  );
                }, childCount: 10),
          ),
        ],
      ),
    );
  }
}
