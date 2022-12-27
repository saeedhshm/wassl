import 'package:flutter/material.dart';

class SendingLoadingWidget extends StatelessWidget {
  const SendingLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
