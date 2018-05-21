import 'package:flutter/material.dart';

class TitlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new Stack(
        children: [
          new Align(
            alignment: Alignment.centerLeft,
            child: new Padding(
              padding: const EdgeInsets.only(left: 130.0),
              child: new Text(
                "Slivers",
                style: Theme.of(context).textTheme.display3.copyWith(
                    color: const Color(0xFF6AA84F),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          new Align(
            alignment: Alignment.bottomRight,
            child: new Padding(
              padding: const EdgeInsets.only(right: 18.0, bottom: 18.0),
              child: new Text(
                'Tomek Polański',
                style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
