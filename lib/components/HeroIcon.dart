import 'package:flutter/material.dart';


class HeroIcon extends StatelessWidget {
  HeroIcon(this.icon);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return new Hero(
      tag: icon,
      child: new CircleAvatar(child: new Icon(icon, color: Colors.white)),
    );
  }
}
