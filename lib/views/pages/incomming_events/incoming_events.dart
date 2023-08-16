import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/app_colors.dart';
import '../../../models/events/event.dart';
import '../../reusable_widgets/icons/back_arrow.dart';
import '../../reusable_widgets/main_appbar.dart';

class IncomingEventsPage extends StatelessWidget {

  final IncomingEvent event;
  const IncomingEventsPage(this.event,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget(
            '${event.title}',
            onBack: () {
              Get.back();
            },
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('details'.tr,style: const TextStyle(
                    color: AppColors.mainGreenColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                  Row(
                    children: [
                      Container(
                        width:40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0.5,
                              blurRadius: 0.5,
                              offset: const Offset(0,1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('assets/images/ad_details/cal.png'),
                        ),
                      ),
                      SizedBox(width: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(event.startDate ,style: const TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold
                              ),),
                              SizedBox(width: 5,),
                      const BackArrowIcon(color: AppColors.darkGreyTextColor,width: 30,),
                              const SizedBox(width: 5,),
                              Text('${event.endDate}',style: const TextStyle(
                                  color: AppColors.darkGreyTextColor,
                                  fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                          Row(
                            children: [
                              Text('${event.startTime} ${'am'.tr}',style: const TextStyle(
                                  color: AppColors.lightGreyTextColor,

                              ),),
                              const SizedBox(width: 5,),
                              const Text(':',style: TextStyle(
                                  color: AppColors.lightGreyTextColor,

                              ),),
                              const SizedBox(width: 5,),
                              Text('${event.endTime} ${'am'.tr}',style: const TextStyle(
                                  color: AppColors.lightGreyTextColor,

                              ),),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      Container(
                        width:40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0.5,
                              blurRadius: 0.5,
                              offset: const Offset(0,1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('assets/images/ad_details/icon.png'),
                        ),
                      ),
                      SizedBox(width: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('place'.tr,style: const TextStyle(
                             color: AppColors.darkGreyTextColor,
                            fontWeight: FontWeight.bold
                              ),),
                          Row(
                            children: [
                              Text('${event.location}',style: const TextStyle(
                                  color: AppColors.lightGreyTextColor,

                              ),),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Text('about_event'.tr,style: TextStyle(
                      color: AppColors.mainGreenColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
                  const SizedBox(height: 16,),
                  Text('${event.details}',style: const TextStyle(
                      color: AppColors.lightGreyTextColor,

                  ),)

                ],
            ),
          ),
              ))
        ],
      ),
    );
  }
}
