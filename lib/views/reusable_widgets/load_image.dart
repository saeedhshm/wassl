import 'package:flutter/material.dart';

class LoadedImageWidget extends StatelessWidget {

  final String imageName;
  final BoxFit fit;
  final Color? color;

  const LoadedImageWidget(this.imageName,{Key? key, this.fit = BoxFit.cover,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(imageName.contains('http')){
      return Image.network(imageName,fit: fit,);
    }
    return Image.asset(imageName,fit: fit,color: color,);
  }
}
