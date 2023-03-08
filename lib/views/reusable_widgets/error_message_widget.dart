import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorMessageWidget extends StatelessWidget {

  final List<String> errorList;
  final Function ()?onTap;
  const ErrorMessageWidget({Key? key,required this.errorList,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.red,
      child: SafeArea(
        child: Column(
          children: [
            InkWell(
                onTap: onTap,
                child: const Icon(Icons.close)),
            Expanded(child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:errorList.map((element) => Text(element,style: const TextStyle(
                    color: Colors.white,

                  ),)).toList(),
                ),
              ),
            ))
          ],
        ),
      ),
    ) ;
  }
}
