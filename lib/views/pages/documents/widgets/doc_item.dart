import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/print_ln.dart';

import '../../../../models/docs/document.dart';
import '../../../../web_services_helper/urls.dart';

class DocItemWidget extends StatelessWidget {
  const DocItemWidget({
    Key? key,
    required this.doc,
  }) : super(key: key);

  final Document doc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text('doc_name'.tr,style: TextStyle(
                    // color: Colors.red
                  ),),
                ),
                Text(':'),
                SizedBox(width: 5,),
                Expanded( flex: 6,child: Text('${doc.name}'),),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text('description'.tr,style: TextStyle(
                    // color: Colors.red
                  ),),
                ),
                Text(':'),
                SizedBox(width: 5,),
                Expanded( flex: 6,child:  Text('${doc.descrition}')),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text('created_at'.tr,style: TextStyle(
                    // color: Colors.red
                  ),),
                ),
                Text(':'),
                SizedBox(width: 5,),
                Expanded( flex: 6,child: Text('${doc.createdAt?.split('T')[0]}'),),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text('eviction_date'.tr,style: TextStyle(
                    // color: Colors.red
                  ),),
                ),
                Text(':'),
                SizedBox(width: 5,),
                Expanded( flex: 6,child: Text(doc.evictionDate ?? '')),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text('download_file'.tr,style: TextStyle(
                    // color: Colors.red
                  ),),
                ),
                Text(':'),
                SizedBox(width: 5,),
                Expanded( flex: 6,child: Row(
                  children: [
                    InkWell(
                        onTap: (){
                          String url = '${appDomain}/${doc.file}';
                          println(url);
                          _launchUrl(url);
                        },
                        child: const Icon(Icons.download,color: AppColors.mainGreenColor,)),
                  ],
                )),
              ],
            ),


          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Could not launch $uri');
    }
  }
}