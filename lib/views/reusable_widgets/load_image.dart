import 'package:flutter/material.dart';

class ImageController {

  final String imageName;
  final BoxFit fit;
  final Color? color;

  const ImageController(this.imageName,{Key? key, this.fit = BoxFit.cover,this.color}) ;

  // @override
  // Widget build(BuildContext context) {
  //
  //   return
  // }

  Widget loadImage(){
    if(imageName.contains('http')){
      return _loadImageFromNetwork();
    }

    return _loadImageFromAssets();
  }

  Widget _loadImageFromAssets(){
    return Image.asset(imageName,fit: fit,color: color,);
  }

  Widget _loadImageFromNetwork(){
    return Image.network(imageName,color: color,fit: fit,errorBuilder: (context,exception,stack){
      // println('image exception $exception');
      return const Icon(Icons.image_not_supported_rounded,);
    },);
  }

}
