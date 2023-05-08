import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../consts_widgets/gradiants.dart';

class CancelUpdateWidget extends StatelessWidget {

  final Function ()?onUpdateRequest;
  final Function ()?onCancelRequest;

  const CancelUpdateWidget({Key? key,required this.onUpdateRequest,required this.onCancelRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: InkWell(
                onTap: onUpdateRequest,
                child: Container(
                  child: Padding(
                    padding:
                    const EdgeInsets
                        .all(
                        10.0),
                    child: Center(
                      child: Text(
                        'update_order'.tr,
                        style: const TextStyle(
                            color: Colors
                                .white,
                            fontSize:
                            17),
                      ),
                    ),
                  ),
                  decoration:
                  BoxDecoration(
                    borderRadius:
                    BorderRadius
                        .circular(
                        8),
                    gradient:
                    greenGradiantAppBar,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: SizedBox(
              child: InkWell(
                onTap: onCancelRequest,
                child: Container(
                  child: Padding(
                    padding:
                    const EdgeInsets
                        .all(
                        10.0),
                    child: Center(
                      child: Text(
                        'cancel_order'.tr,
                        style: const TextStyle(
                            color: Colors
                                .white,
                            fontSize:
                            17),
                      ),
                    ),
                  ),
                  decoration:
                  BoxDecoration(
                    borderRadius:
                    BorderRadius
                        .circular(
                        8),
                    gradient:
                    redGradiantCancel,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
