import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Bar extends StatefulWidget {
  const Bar({Key key, this.start, this.end}) : super(key: key);

  final Color start;
  final Color end;

  static Widget createSettings({
    double minExtent,
    double maxExtent,
    @required double currentExtent,
    @required Widget child,
  }) {
    assert(currentExtent != null);
    return new _BarSettings(
      minExtent: minExtent ?? currentExtent,
      maxExtent: maxExtent ?? currentExtent,
      currentExtent: currentExtent,
      child: child,
    );
  }

  @override
  _BarState createState() => new _BarState();
}

class _BarState extends State<Bar> {
  @override
  Widget build(BuildContext context) {
    final _BarSettings settings =
        context.inheritFromWidgetOfExactType(_BarSettings);
    assert(settings != null,
        'A Bar must be wrapped in the widget returned by Bar.createSettings().');

    final double deltaExtent = settings.maxExtent - settings.minExtent;

    // 0.0 -> Expanded
    // 1.0 -> Collapsed to toolbar
    final double t =
        (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
            .clamp(0.0, 1.0);

    return new Container(
      height: double.infinity,
      width: double.infinity,
      color: Color.lerp(widget.start, widget.end, t),
    );
  }
}

class _BarSettings extends InheritedWidget {
  const _BarSettings({
    Key key,
    this.minExtent,
    this.maxExtent,
    this.currentExtent,
    Widget child,
  }) : super(key: key, child: child);

  final double minExtent;
  final double maxExtent;
  final double currentExtent;

  @override
  bool updateShouldNotify(_BarSettings oldWidget) {
    return minExtent != oldWidget.minExtent ||
        maxExtent != oldWidget.maxExtent ||
        currentExtent != oldWidget.currentExtent;
  }
}
