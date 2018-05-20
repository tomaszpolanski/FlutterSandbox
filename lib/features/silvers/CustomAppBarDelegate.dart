import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_view/features/silvers/Bar.dart';
import 'package:flutter_view/features/silvers/SimpleAppBar.dart';
import 'package:meta/meta.dart';

class CustomAppBarDelegate extends SliverPersistentHeaderDelegate {
  CustomAppBarDelegate({
    @required this.automaticallyImplyLeading,
    @required this.flexibleSpace,
    @required this.primary,
    @required this.titleSpacing,
    @required this.expandedHeight,
    @required this.collapsedHeight,
    @required this.topPadding,
    @required this.floating,
    @required this.pinned,
    @required this.snapConfiguration,
  }) : assert(primary || topPadding == 0.0),
        _bottomHeight = 0.0;
  final bool automaticallyImplyLeading;
  final Widget flexibleSpace;
  final bool primary;
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
    final Widget appBar = Bar.createSettings(
      minExtent: minExtent,
      maxExtent: maxExtent,
      currentExtent: math.max(minExtent, maxExtent - shrinkOffset),
      child: new SimpleAppBar(
        flexibleSpace: flexibleSpace,
      ),
    );
    return floating ? new _FloatingAppBar(child: appBar) : appBar;
  }

  @override
  bool shouldRebuild(covariant CustomAppBarDelegate oldDelegate) {
    return flexibleSpace != oldDelegate.flexibleSpace;
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
