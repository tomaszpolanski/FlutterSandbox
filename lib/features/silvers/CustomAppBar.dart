import 'package:flutter/material.dart';
import 'package:flutter_view/features/silvers/CustomAppBarDelegate.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
    this.flexibleSpace,
    this.expandedHeight,
  }) : super(key: key);

  final Widget flexibleSpace;
  final double expandedHeight;

  @override
  Widget build(BuildContext context) {
    return new MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: new SliverPersistentHeader(
        delegate: new CustomAppBarDelegate(
          flexibleSpace: flexibleSpace,
          expandedHeight: expandedHeight,
        ),
      ),
    );
  }
}
