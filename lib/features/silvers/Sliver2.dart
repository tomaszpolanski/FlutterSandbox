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
            pinned: true,
            expandedHeight: 150.0,
            flexibleSpace: new Bar(
              title: new Text('Demo'),
              background: new Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.red,
              ),
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
