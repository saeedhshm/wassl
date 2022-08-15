import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class SvgWidget extends StatelessWidget {

  final String assetName;
  const SvgWidget(this.assetName,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
        assetName,
      placeholderBuilder: (BuildContext context) => Container(
          padding: const EdgeInsets.all(30.0),
          child: const CircularProgressIndicator()),
    );
  }
}
