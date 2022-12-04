import 'package:flutter/material.dart';

class LoadingImageWidget extends StatelessWidget {

  final String imageName;

  const LoadingImageWidget({Key? key,required this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(imageName);
  }
}
