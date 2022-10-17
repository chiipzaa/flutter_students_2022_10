import 'package:flutter/material.dart';

class CMText extends StatelessWidget {
  String title;

  CMText(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Text(title),
    );
  }
}
