import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/reusable_widgets/icons/chat_icon.dart';

import '../../../../../consts_widgets/gradiants.dart';
import '../../../../../reusable_widgets/circular_widget.dart';
import '../../../../../reusable_widgets/textfield_with_icons.dart';

class CommentsWidget extends StatelessWidget {
  CommentsWidget({Key? key}) : super(key: key);
  final heightBetweenWidgets = 10.0;
  final reasonCtrl= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('comments'.tr),
        SizedBox(height: heightBetweenWidgets,),
        Row(
          children: [
            CircularWidget(
              size: 50,
              child: Image.asset('assets/images/profile/1.png'),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: TextFormFieldWithIcons(
                prefixIcon: SizedBox(
                  child: ChatConversationIcon(),
                ),
                maxLines: 1,
                hintText: 'add_comment'.tr,
                controller: reasonCtrl,
                onChange: (value) {
                  // controller.reason = value;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: heightBetweenWidgets,),
        Row(
          children: [
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                gradient: greenGradiantAppBarSecond,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 25),
                child: Text('send'.tr,style: const TextStyle(
                    color: Colors.white
                ),),
              ),
            )
          ],
        ),
      ],
    );
  }
}
