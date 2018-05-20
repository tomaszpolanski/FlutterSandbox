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
    this.leading,
    this.automaticallyImplyLeading: true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.forceElevated: false,
    this.backgroundColor,
    this.brightness,
    this.iconTheme,
    this.textTheme,
    this.primary: true,
    this.centerTitle,
    this.titleSpacing: NavigationToolbar.kMiddleSpacing,
    this.expandedHeight,
    this.floating: false,
    this.pinned: false,
    this.snap: false,
  }) : assert(automaticallyImplyLeading != null),
        assert(forceElevated != null),
        assert(primary != null),
        assert(titleSpacing != null),
        assert(floating != null),
        assert(pinned != null),
        assert(snap != null),
        assert(floating || !snap, 'The "snap" argument only makes sense for floating app bars.'),
        super(key: key);

  /// A widget to display before the [title].
  ///
  /// If this is null and [automaticallyImplyLeading] is set to true, the [AppBar] will
  /// imply an appropriate widget. For example, if the [AppBar] is in a [Scaffold]
  /// that also has a [Drawer], the [Scaffold] will fill this widget with an
  /// [IconButton] that opens the drawer. If there's no [Drawer] and the parent
  /// [Navigator] can go back, the [AppBar] will use a [BackButton] that calls
  /// [Navigator.maybePop].
  final Widget leading;

  /// Controls whether we should try to imply the leading widget if null.
  ///
  /// If true and [leading] is null, automatically try to deduce what the leading
  /// widget should be. If false and [leading] is null, leading space is given to [title].
  /// If leading widget is not null, this parameter has no effect.
  final bool automaticallyImplyLeading;

  /// The primary widget displayed in the appbar.
  ///
  /// Typically a [Text] widget containing a description of the current contents
  /// of the app.
  final Widget title;

  /// Widgets to display after the [title] widget.
  ///
  /// Typically these widgets are [IconButton]s representing common operations.
  /// For less common operations, consider using a [PopupMenuButton] as the
  /// last action.
  ///
  /// ## Sample code
  ///
  /// ```dart
  /// new Scaffold(
  ///   body: new CustomScrollView(
  ///     primary: true,
  ///     slivers: <Widget>[
  ///       new SliverAppBar(
  ///         title: new Text('Hello World'),
  ///         actions: <Widget>[
  ///           new IconButton(
  ///             icon: new Icon(Icons.shopping_cart),
  ///             tooltip: 'Open shopping cart',
  ///             onPressed: () {
  ///               // handle the press
  ///             },
  ///           ),
  ///         ],
  ///       ),
  ///       // ...rest of body...
  ///     ],
  ///   ),
  /// )
  /// ```
  final List<Widget> actions;

  /// This widget is stacked behind the toolbar and the tabbar. It's height will
  /// be the same as the app bar's overall height.
  ///
  /// Typically a [FlexibleSpaceBar]. See [FlexibleSpaceBar] for details.
  final Widget flexibleSpace;

  /// This widget appears across the bottom of the appbar.
  ///
  /// Typically a [TabBar]. Only widgets that implement [PreferredSizeWidget] can
  /// be used at the bottom of an app bar.
  ///
  /// See also:
  ///
  ///  * [PreferredSize], which can be used to give an arbitrary widget a preferred size.
  final PreferredSizeWidget bottom;

  /// The z-coordinate at which to place this app bar when it is above other
  /// content. This controls the size of the shadow below the app bar.
  ///
  /// Defaults to 4, the appropriate elevation for app bars.
  ///
  /// If [forceElevated] is false, the elevation is ignored when the app bar has
  /// no content underneath it. For example, if the app bar is [pinned] but no
  /// content is scrolled under it, or if it scrolls with the content, then no
  /// shadow is drawn, regardless of the value of [elevation].
  final double elevation;

  /// Whether to show the shadow appropriate for the [elevation] even if the
  /// content is not scrolled under the [AppBar].
  ///
  /// Defaults to false, meaning that the [elevation] is only applied when the
  /// [AppBar] is being displayed over content that is scrolled under it.
  ///
  /// When set to true, the [elevation] is applied regardless.
  ///
  /// Ignored when [elevation] is zero.
  final bool forceElevated;

  /// The color to use for the app bar's material. Typically this should be set
  /// along with [brightness], [iconTheme], [textTheme].
  ///
  /// Defaults to [ThemeData.primaryColor].
  final Color backgroundColor;

  /// The brightness of the app bar's material. Typically this is set along
  /// with [backgroundColor], [iconTheme], [textTheme].
  ///
  /// Defaults to [ThemeData.primaryColorBrightness].
  final Brightness brightness;

  /// The color, opacity, and size to use for app bar icons. Typically this
  /// is set along with [backgroundColor], [brightness], [textTheme].
  ///
  /// Defaults to [ThemeData.primaryIconTheme].
  final IconThemeData iconTheme;

  /// The typographic styles to use for text in the app bar. Typically this is
  /// set along with [brightness] [backgroundColor], [iconTheme].
  ///
  /// Defaults to [ThemeData.primaryTextTheme].
  final TextTheme textTheme;

  /// Whether this app bar is being displayed at the top of the screen.
  ///
  /// If this is true, the top padding specified by the [MediaQuery] will be
  /// added to the top of the toolbar.
  final bool primary;

  /// Whether the title should be centered.
  ///
  /// Defaults to being adapted to the current [TargetPlatform].
  final bool centerTitle;

  /// The spacing around [title] content on the horizontal axis. This spacing is
  /// applied even if there is no [leading] content or [actions]. If you want
  /// [title] to take all the space available, set this value to 0.0.
  ///
  /// Defaults to [NavigationToolbar.kMiddleSpacing].
  final double titleSpacing;

  /// The size of the app bar when it is fully expanded.
  ///
  /// By default, the total height of the toolbar and the bottom widget (if
  /// any). If a [flexibleSpace] widget is specified this height should be big
  /// enough to accommodate whatever that widget contains.
  ///
  /// This does not include the status bar height (which will be automatically
  /// included if [primary] is true).
  final double expandedHeight;

  /// Whether the app bar should become visible as soon as the user scrolls
  /// towards the app bar.
  ///
  /// Otherwise, the user will need to scroll near the top of the scroll view to
  /// reveal the app bar.
  ///
  /// If [snap] is true then a scroll that exposes the app bar will trigger an
  /// animation that slides the entire app bar into view. Similarly if a scroll
  /// dismisses the app bar, the animation will slide it completely out of view.
  final bool floating;

  /// Whether the app bar should remain visible at the start of the scroll view.
  ///
  /// The app bar can still expand an contract as the user scrolls, but it will
  /// remain visible rather than being scrolled out of view.
  final bool pinned;

  /// If [snap] and [floating] are true then the floating app bar will "snap"
  /// into view.
  ///
  /// If [snap] is true then a scroll that exposes the floating app bar will
  /// trigger an animation that slides the entire app bar into view. Similarly if
  /// a scroll dismisses the app bar, the animation will slide the app bar
  /// completely out of view.
  ///
  /// Snapping only applies when the app bar is floating, not when the appbar
  /// appears at the top of its scroll view.
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
    final double collapsedHeight = (widget.pinned && widget.floating && widget.bottom != null)
        ? widget.bottom.preferredSize.height + topPadding : null;

    return new MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: new SliverPersistentHeader(
        floating: widget.floating,
        pinned: widget.pinned,
        delegate: new CustomAppBarDelegate(
          leading: widget.leading,
          automaticallyImplyLeading: widget.automaticallyImplyLeading,
          title: widget.title,
          actions: widget.actions,
          flexibleSpace: widget.flexibleSpace,
          bottom: widget.bottom,
          elevation: widget.elevation,
          forceElevated: widget.forceElevated,
          backgroundColor: widget.backgroundColor,
          brightness: widget.brightness,
          iconTheme: widget.iconTheme,
          textTheme: widget.textTheme,
          primary: widget.primary,
          centerTitle: widget.centerTitle,
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
