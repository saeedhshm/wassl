import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/date_picker_config.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:wassl/getx_controllers/calendar/calendar_controller.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/views/pages/calendar/widgets/day_builder.dart';

import '../../../../helpers/constants/app_colors.dart';

class CalendarWidget extends StatefulWidget {

   CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {

  final CalendarController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        bottom: 15
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,

        child: Calendar(
          // startOnMonday: false,
          // weekDays: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
          // eventsList: _eventList,
          weekDays: const ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
          isExpandable: false,

          initialDate: controller.dateTime,
          datePickerConfig: DatePickerConfig(
            initialDate: controller.dateTime
          ),
          eventDoneColor: Colors.green,
          selectedColor: Colors.pink,
          selectedTodayColor: Colors.red,
          todayColor: Colors.blue,
          eventColor: null,
          locale: 'ar_SA',
          // todayButtonText: 'Heute',
          // allDayEventText: 'Ganztägig',
          multiDayEndText: 'Ende',
          isExpanded: true,
          // expandableDateFormat: '',
          // datePickerType: DatePickerType.date,
          hideBottomBar: true,
          // todayButtonText: ''.tr,
          todayButtonText: '',
          onRangeSelected:(value){

            println('onRangeSelected $value');
          } ,

          onDateSelected: (dt){
            DateTime dateTime = dt;
            if(dt.hour == 23){
              var newDate = DateTime(dt.year,dt.month,dt.day + 1);
              dateTime = newDate;

            }else{
              dateTime = dt;
            }
            _currentDay = dateTime;

            controller.setSelectedDate(dateTime);
            setState(() {

            });
          },
          dayBuilder: (context,dt){
           return  dayBuilder(context: context, dt: dt, controller: controller, currentDay: _currentDay);
          },

          defaultOutOfMonthDayColor: Colors.green,
          defaultDayColor: Colors.grey,
          onMonthChanged: (dateTime){



            if(controller.dateTime.month != dateTime.month) {
              controller.dateTime = dateTime;
              controller.retrieveAttendanceData();
            }
            setState(() {

            });
          },
          dayOfWeekStyle: const TextStyle(
              color: AppColors.lightGreyTextColor, fontWeight: FontWeight.w800, fontSize: 11),

        ),
      ),
    );
  }





  DateTime _currentDay = DateTime.now();





  List<DateTime> removeDuplicates(List<DateTime> items) {
    List<DateTime> uniqueItems = []; // uniqueList
    var uniqueIDs = items
        .map((e) => e.day)
        .toSet(); //list if UniqueID to remove duplicates
    uniqueIDs.forEach((e) {
      uniqueItems.add(items.firstWhere((i) => i.day == e));
    }); // populate uniqueItems with equivalent original Batch items
    return uniqueItems;//send back the unique items list
  }



}
