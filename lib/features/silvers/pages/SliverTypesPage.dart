import 'package:flutter/material.dart';

class SliverTypesPage extends StatelessWidget {
  static const _kMostUsed = const [
    'SilverList',
    'SliverFixedExtentList',
    'SilverGrid',
    'SliverAppBar',
    'SliverPersistentHeader',
    'SliverFillViewport',
    'SliverToBoxAdapter',
  ];

  static const _kTheRest = const [
    'SliverPrototypeExtentList',
    'SliverFillRemaining',
    'SliverPadding',
    'RenderSliverHelpers (mixin)',
    'RenderSliverMultiBoxAdaptor (abstract)',
    'RenderSliverFixedExtentBoxAdaptor (abstract)',
    'RenderSliverFillViewport',
    'RenderSliverFixedExtentList',
    'RenderSliverGrid',
    'RenderSliverList',
    'RenderSliverPadding',
    'RenderSliverPersistentHeader (abstract)',
    'RenderSliverFloatingPersistentHeader',
    'RenderSliverFloatingPinnedPersistentHeader',
    'RenderSliverPinnedPersistentHeader',
    'RenderSliverScrollingPersistentHeader',
    'RenderSliverSingleBoxAdapter (abstract)',
    'RenderSliverFillRemaining',
    'RenderSliverToBoxAdapter',
  ]; // source: https://stackoverflow.com/questions/44493372/is-there-any-definite-list-of-sliver-widgets

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) =>
        new CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            new SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              flexibleSpace: new FlexibleSpaceBar(
                title: new Text(
                  'Sliver Types',
                  style: Theme
                      .of(context)
                      .textTheme
                      .display1
                      .copyWith(
                      color: const Color(0xFF6AA84F),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            new SliverToBoxAdapter(
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  "Most Used",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline
                      .copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            new SliverGrid(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 20.0,
                childAspectRatio: 4.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                _sliverTypeDelegate(_kMostUsed),
                childCount: _kMostUsed.length,
              ),
            ),
            new SliverToBoxAdapter(
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  "And the rest Used",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline
                      .copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            new SliverGrid(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 20.0,
                childAspectRatio: 4.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                _sliverTypeDelegate(_kTheRest),
                childCount: _kTheRest.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _sliverTypeDelegate(List<String> data) {
    return (BuildContext context, int index) {
      final background = Colors.green[100 + 100 * (index % 8)];
      return new Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        alignment: Alignment.center,
        color: background,
        child: new Text(
          data[index],
          style: Theme
              .of(context)
              .textTheme
              .title
              .copyWith(
            color: background.computeLuminance() >= 0.3
                ? Colors.black
                : Colors.white,
          ),
        ),
      );
    };
  }
}
