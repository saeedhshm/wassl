import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class SvgWidget extends StatelessWidget {

  final String assetName;
  final Color? color;
  const SvgWidget(this.assetName,{this.color,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
        assetName,
      color: color,
      placeholderBuilder: (BuildContext context) => Container(
          padding: const EdgeInsets.all(30.0),
          child: const CircularProgressIndicator()),
    );
  }
}
