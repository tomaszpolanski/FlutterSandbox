import 'package:flutter/material.dart';

class MultiChildLayout extends StatelessWidget {
  MultiChildLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CustomMultiChildLayout'),
          automaticallyImplyLeading: true,
        ),
        body: new CustomMultiChildLayout(
          delegate: new LongAndShortDelegate(),
          children: <Widget>[
            new LayoutId(
              id: WidgetSize.long,
              child: new Container(
                padding: const EdgeInsets.all(8.0),
                child: new RaisedButton(
                  onPressed: () {},
                  child: Text("Loooooooooooooooong text"),
                ),
              ),
            ),
            new LayoutId(
              id: WidgetSize.short,
              child: new Container(
                padding: const EdgeInsets.all(8.0),
                child: new RaisedButton(
                  onPressed: () {},
                  child: Text("Short text"),
                ),
              ),
            ),
          ],
        ));
  }
}

enum WidgetSize {
  long,
  short,
}

class LongAndShortDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    Size longSize = Size.zero;

    if (hasChild(WidgetSize.long)) {
      longSize = layoutChild(WidgetSize.long, new BoxConstraints.loose(size));
      positionChild(WidgetSize.long, Offset.zero);
    }

    if (hasChild(WidgetSize.short)) {
      layoutChild(WidgetSize.short, new BoxConstraints.tight(longSize));
      positionChild(WidgetSize.short, new Offset(0.0, longSize.height));
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) => false;
}
