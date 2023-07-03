import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/models/events/event.dart';
import 'package:wassl/views/pages/incomming_events/incoming_events.dart';

import '../../../../getx_controllers/home/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';

class NextEvents extends StatelessWidget {

  NextEvents({Key? key}) : super(key: key);
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Row(
              children: [
                Text(
                  'next_events'.tr,
                  style: const TextStyle(
                      color: AppColors.darkGreyTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 8,),
          SingleChildScrollView(
            child: Row(
              children: controller.events.value.events.map((e) => ItemWidget(e)).toList(),
            ),
            scrollDirection: Axis.horizontal,
          )
        ],
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {

  final IncomingEvent event;
  const ItemWidget(this.event,{
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: ()=>Get.to(()=>IncomingEventsPage(event)),
          child: Container(
            width: Get.width * 0.5,
            margin: EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/prosedures/cal.png',width: 20,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Text(event.startDate ?? '',style: const TextStyle(
                          color: AppColors.lightGreyTextColor,
                          fontSize: 9
                      ),),
                      SizedBox(width: 5,),
                      Image.asset('assets/images/back_arrow.png',color: AppColors.darkGreyTextColor,width: 20,),
                      const SizedBox(width: 5,),
                       Text('${event.endDate}',style: TextStyle(
                          color: AppColors.lightGreyTextColor,
                          fontSize: 9
                      ),),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Text('${event.title}',style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13
                  ),),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Text('${event.startTime} ${'am'.tr}',style: const TextStyle(
                          color: AppColors.lightGreyTextColor,
                          fontSize: 9
                      ),),
                      const SizedBox(width: 5,),
                      const Text(':',style: TextStyle(
                          color: AppColors.lightGreyTextColor,
                          fontSize: 9
                      ),),
                      const SizedBox(width: 5,),
                      Text('${event.endTime} ${'am'.tr}',style: const TextStyle(
                          color: AppColors.lightGreyTextColor,
                          fontSize: 9
                      ),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10,)
      ],
    );
  }
}
