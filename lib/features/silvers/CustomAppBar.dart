import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_view/features/silvers/CustomAppBarDelegate.dart';

class CustomAppBar extends StatefulWidget {
  /// Creates a material design app bar that can be placed in a [CustomScrollView].
  ///
  /// The arguments [forceElevated], [primary], [floating], [pinned], [snap]
  /// and [automaticallyImplyLeading] must not be null.
  const CustomAppBar({
    Key key,
    this.automaticallyImplyLeading: true,
    this.flexibleSpace,
    this.primary: true,
    this.titleSpacing: NavigationToolbar.kMiddleSpacing,
    this.expandedHeight,
    this.floating: false,
    this.pinned: false,
    this.snap: false,
  }) : assert(automaticallyImplyLeading != null),
        assert(primary != null),
        assert(titleSpacing != null),
        assert(floating != null),
        assert(pinned != null),
        assert(snap != null),
        assert(floating || !snap, 'The "snap" argument only makes sense for floating app bars.'),
        super(key: key);

  final bool automaticallyImplyLeading;
  final Widget flexibleSpace;
  final bool primary;
  final double titleSpacing;
  final double expandedHeight;
  final bool floating;
  final bool pinned;
  final bool snap;

  @override
  _SliverAppBarState createState() => new _SliverAppBarState();
}

// This class is only Stateful because it owns the TickerProvider used
// by the floating appbar snap animation (via FloatingHeaderSnapConfiguration).
class _SliverAppBarState extends State<CustomAppBar> with TickerProviderStateMixin {
  FloatingHeaderSnapConfiguration _snapConfiguration;

  void _updateSnapConfiguration() {
    if (widget.snap && widget.floating) {
      _snapConfiguration = new FloatingHeaderSnapConfiguration(
        vsync: this,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 200),
      );
    } else {
      _snapConfiguration = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _updateSnapConfiguration();
  }

  @override
  void didUpdateWidget(CustomAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.snap != oldWidget.snap || widget.floating != oldWidget.floating)
      _updateSnapConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    assert(!widget.primary || debugCheckHasMediaQuery(context));
    final double topPadding = widget.primary ? MediaQuery.of(context).padding.top : 0.0;
    final double collapsedHeight = (widget.pinned && widget.floating)
        ? topPadding : null;

    return new MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: new SliverPersistentHeader(
        floating: widget.floating,
        pinned: widget.pinned,
        delegate: new CustomAppBarDelegate(
          automaticallyImplyLeading: widget.automaticallyImplyLeading,
          flexibleSpace: widget.flexibleSpace,
          primary: widget.primary,
          titleSpacing: widget.titleSpacing,
          expandedHeight: widget.expandedHeight,
          collapsedHeight: collapsedHeight,
          topPadding: topPadding,
          floating: widget.floating,
          pinned: widget.pinned,
          snapConfiguration: _snapConfiguration,
        ),
      ),
    );
  }
}
