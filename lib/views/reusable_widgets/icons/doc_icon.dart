import 'package:flutter/material.dart';

class DocIcon extends StatelessWidget {

  final Color? color;
  const DocIcon({this.color,super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/prosedures/docs.png',color: color,);
  }
}
