import 'package:flutter/material.dart';
import '../../../helpers/constants/sring_constans.dart';
import '../../reusable_widgets/localized_text.dart';
import '../../reusable_widgets/svg_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Hero(
          tag: logoAppHeroTag,
          child: Container(
            color: Colors.blue,
            width: 200,
              height: 200,
              child: SvgWidget("assets/images/wasl.svg")),
        ),
            Container(
              child: LocalizedText("welcome_to_wasl",textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
            ),
            Container(
              child: LocalizedText("you_can_enter_to_account",textStyle: TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                color: Colors.grey
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
