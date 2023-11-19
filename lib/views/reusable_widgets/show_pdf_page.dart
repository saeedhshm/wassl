import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../consts_widgets/gradiants.dart';
import 'icons/back_arrow.dart';

class ShowPdfPage extends StatelessWidget {

  final Uint8List pdfData;
  const ShowPdfPage(this.pdfData,{super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: greenGradiantAppBarSecond
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 16,top: 50),
              child: Row(
                children: [
                  Text('report'.tr,style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),),
                  const Spacer(),
                  InkWell(onTap:(){

                    Get.back();
                  },child: const BackArrowIcon(),),
                ],
              ),
            ),
          ),
          Expanded(child: PDFView(
            // filePath: filePath,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: false,
            pageFling: false,
            pdfData: pdfData,

          ))
        ],
      ),
    );
  }
}
