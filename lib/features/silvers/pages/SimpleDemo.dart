import 'package:flutter/material.dart';

class SimpleDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new CustomScrollView(
      slivers: <Widget>[
        new SliverAppBar(
          floating: true,
          snap: true,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: false,
          flexibleSpace: new FlexibleSpaceBar(
            title: new Text(
              'Sliver Examples',
              style: Theme.of(context).textTheme.display1.copyWith(
                  color: const Color(0xFF6AA84F), fontWeight: FontWeight.bold),
            ),
          ),
        ),
        new SliverGrid(
          gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 4.0,
          ),
          delegate: new SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return new Container(
                alignment: Alignment.center,
                color: Colors.teal[100 * (index % 9)],
                child: new Text(
                  'grid item $index',
                  style: Theme.of(context).textTheme.title,
                ),
              );
            },
            childCount: 20,
          ),
        ),
        new SliverFixedExtentList(
          itemExtent: 50.0,
          delegate:
              new SliverChildBuilderDelegate((BuildContext context, int index) {
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
        new SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: new SliverFixedExtentList(
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
        ),
        new SliverToBoxAdapter(
          child: const Text("First SliverToBoxAdapter"),
        ),
        new SliverToBoxAdapter(
          child: const Text("Second SliverToBoxAdapter"),
        ),
        new SliverFillViewport(
          delegate: new SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return new Card(
                color: Colors.yellowAccent,
                child: new Text("Fill Viewport $index"),
              );
            },
            childCount: 2,
          ),
        ),
      ],
    );
  }
}
