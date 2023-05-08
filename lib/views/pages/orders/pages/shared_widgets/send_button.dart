import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../consts_widgets/gradiants.dart';

class SendButtonWidget extends StatelessWidget {

  final Function ()_addNewRequest;
  const SendButtonWidget(this._addNewRequest,{Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _addNewRequest,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding:
          const EdgeInsets.all(
              10.0),
          child: Center(
            child: Text(
              'send'.tr,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17),
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(
              8),
          gradient:
          greenGradiantAppBar,
        ),
      ),
    );
  }
}
