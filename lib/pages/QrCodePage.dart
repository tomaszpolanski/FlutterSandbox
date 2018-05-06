import 'package:flutter/material.dart';

class QrCodePage extends StatefulWidget {
  QrCodePage({Key key, this.title}) : super(key: key);

  final String title;

  final Map<String, dynamic> pluginParameters = {};

  @override
  _QrCodePageState createState() => new _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('CustomMultiChildLayout')),
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
