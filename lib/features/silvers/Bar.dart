import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Bar extends StatefulWidget {
  /// Creates a flexible space bar.
  ///
  /// Most commonly used in the [AppBar.flexibleSpace] field.
  const Bar({Key key, this.title, this.background, this.centerTitle})
      : super(key: key);

  /// The primary contents of the flexible space bar when expanded.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Shown behind the [title] when expanded.
  ///
  /// Typically an [Image] widget with [Image.fit] set to [BoxFit.cover].
  final Widget background;

  /// Whether the title should be centered.
  ///
  /// Defaults to being adapted to the current [TargetPlatform].
  final bool centerTitle;

  /// Wraps a widget that contains an [AppBar] to convey sizing information down
  /// to the [FlexibleSpaceBar].
  ///
  /// Used by [Scaffold] and [SliverAppBar].
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

    final List<Widget> children = <Widget>[];

    final double deltaExtent = settings.maxExtent - settings.minExtent;

    // 0.0 -> Expanded
    // 1.0 -> Collapsed to toolbar
    final double t =
        (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
            .clamp(0.0, 1.0);

    final double parallax =
        new Tween<double>(begin: 0.0, end: deltaExtent / 4.0).lerp(t);

    children.add(new Positioned(
        top: -parallax,
        left: 0.0,
        right: 0.0,
        height: settings.maxExtent,
        child: new Container(
          height: double.infinity,
          width: double.infinity,
          color: Color.lerp(Colors.red, Colors.purple, t),
        )));

    return new ClipRect(child: new Stack(children: children));
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
