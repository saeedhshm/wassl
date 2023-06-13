import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {

  final Color color;
  final double size;
  const DotWidget({
    Key? key,
    required this.color,
    required this.size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:color
      ),
    );
  }
}