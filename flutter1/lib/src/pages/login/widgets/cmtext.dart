import 'package:flutter/material.dart';

class CMText extends StatelessWidget {
  String title;
  MaterialColor color;

  CMText(this.title, {required this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Text(title),
    );
  }
}
