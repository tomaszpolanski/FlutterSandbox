import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_view/features/silvers/Bar.dart';
import 'package:meta/meta.dart';

class CustomAppBarDelegate extends SliverPersistentHeaderDelegate {
  CustomAppBarDelegate({
    @required this.leading,
    @required this.automaticallyImplyLeading,
    @required this.title,
    @required this.actions,
    @required this.flexibleSpace,
    @required this.bottom,
    @required this.elevation,
    @required this.forceElevated,
    @required this.backgroundColor,
    @required this.brightness,
    @required this.iconTheme,
    @required this.textTheme,
    @required this.primary,
    @required this.centerTitle,
    @required this.titleSpacing,
    @required this.expandedHeight,
    @required this.collapsedHeight,
    @required this.topPadding,
    @required this.floating,
    @required this.pinned,
    @required this.snapConfiguration,
  }) : assert(primary || topPadding == 0.0),
        _bottomHeight = bottom?.preferredSize?.height ?? 0.0;

  final Widget leading;
  final bool automaticallyImplyLeading;
  final Widget title;
  final List<Widget> actions;
  final Widget flexibleSpace;
  final PreferredSizeWidget bottom;
  final double elevation;
  final bool forceElevated;
  final Color backgroundColor;
  final Brightness brightness;
  final IconThemeData iconTheme;
  final TextTheme textTheme;
  final bool primary;
  final bool centerTitle;
  final double titleSpacing;
  final double expandedHeight;
  final double collapsedHeight;
  final double topPadding;
  final bool floating;
  final bool pinned;

  final double _bottomHeight;

  @override
  double get minExtent => collapsedHeight ?? (topPadding + kToolbarHeight + _bottomHeight);

  @override
  double get maxExtent => math.max(topPadding + (expandedHeight ?? kToolbarHeight + _bottomHeight), minExtent);

  @override
  final FloatingHeaderSnapConfiguration snapConfiguration;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double visibleMainHeight = maxExtent - shrinkOffset - topPadding;
    final double toolbarOpacity = pinned && !floating ? 1.0
        : ((visibleMainHeight - _bottomHeight) / kToolbarHeight).clamp(0.0, 1.0);
    final Widget appBar = Bar.createSettings(
      minExtent: minExtent,
      maxExtent: maxExtent,
      currentExtent: math.max(minExtent, maxExtent - shrinkOffset),
      child: new AppBar(
        leading: leading,
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: title,
        actions: actions,
        flexibleSpace: flexibleSpace,
        bottom: bottom,
        elevation: forceElevated || overlapsContent || (pinned && shrinkOffset > maxExtent - minExtent) ? elevation ?? 4.0 : 0.0,
        backgroundColor: backgroundColor,
        brightness: brightness,
        iconTheme: iconTheme,
        textTheme: textTheme,
        primary: primary,
        centerTitle: centerTitle,
        titleSpacing: titleSpacing,
        toolbarOpacity: toolbarOpacity,
        bottomOpacity: pinned ? 1.0 : (visibleMainHeight / _bottomHeight).clamp(0.0, 1.0),
      ),
    );
    return floating ? new _FloatingAppBar(child: appBar) : appBar;
  }

  @override
  bool shouldRebuild(covariant CustomAppBarDelegate oldDelegate) {
    return leading != oldDelegate.leading
        || automaticallyImplyLeading != oldDelegate.automaticallyImplyLeading
        || title != oldDelegate.title
        || actions != oldDelegate.actions
        || flexibleSpace != oldDelegate.flexibleSpace
        || bottom != oldDelegate.bottom
        || _bottomHeight != oldDelegate._bottomHeight
        || elevation != oldDelegate.elevation
        || backgroundColor != oldDelegate.backgroundColor
        || brightness != oldDelegate.brightness
        || iconTheme != oldDelegate.iconTheme
        || textTheme != oldDelegate.textTheme
        || primary != oldDelegate.primary
        || centerTitle != oldDelegate.centerTitle
        || titleSpacing != oldDelegate.titleSpacing
        || expandedHeight != oldDelegate.expandedHeight
        || topPadding != oldDelegate.topPadding
        || pinned != oldDelegate.pinned
        || floating != oldDelegate.floating
        || snapConfiguration != oldDelegate.snapConfiguration;
  }

  @override
  String toString() {
    return '${describeIdentity(this)}(topPadding: ${topPadding.toStringAsFixed(1)}, bottomHeight: ${_bottomHeight.toStringAsFixed(1)}, ...)';
  }
}


class _FloatingAppBar extends StatefulWidget {
  const _FloatingAppBar({ Key key, this.child }) : super(key: key);

  final Widget child;

  @override
  _FloatingAppBarState createState() => new _FloatingAppBarState();
}

// A wrapper for the widget created by _SliverAppBarDelegate that starts and
/// stops the floating appbar's snap-into-view or snap-out-of-view animation.
class _FloatingAppBarState extends State<_FloatingAppBar> {
  ScrollPosition _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_position != null)
      _position.isScrollingNotifier.removeListener(_isScrollingListener);
    _position = Scrollable.of(context)?.position;
    if (_position != null)
      _position.isScrollingNotifier.addListener(_isScrollingListener);
  }

  @override
  void dispose() {
    if (_position != null)
      _position.isScrollingNotifier.removeListener(_isScrollingListener);
    super.dispose();
  }

  RenderSliverFloatingPersistentHeader _headerRenderer() {
    return context.ancestorRenderObjectOfType(const TypeMatcher<RenderSliverFloatingPersistentHeader>());
  }

  void _isScrollingListener() {
    if (_position == null)
      return;

    // When a scroll stops, then maybe snap the appbar into view.
    // Similarly, when a scroll starts, then maybe stop the snap animation.
    final RenderSliverFloatingPersistentHeader header = _headerRenderer();
    if (_position.isScrollingNotifier.value)
      header?.maybeStopSnapAnimation(_position.userScrollDirection);
    else
      header?.maybeStartSnapAnimation(_position.userScrollDirection);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
