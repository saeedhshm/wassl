import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/date_picker_config.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:wassl/getx_controllers/calendar/calendar_controller.dart';
import 'package:wassl/helpers/constants/print_ln.dart';

import '../../helpers/constants/app_colors.dart';

class CalendarWidget extends StatefulWidget {

   CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {

  final CalendarController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Calendar(
        startOnMonday: true,
        weekDays: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
        // eventsList: _eventList,
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
        locale: 'ar',
        // todayButtonText: 'Heute',
        // allDayEventText: 'Ganztägig',
        multiDayEndText: 'Ende',
        isExpanded: true,
        // expandableDateFormat: '',
        // datePickerType: DatePickerType.date,
        hideBottomBar: true,
        todayButtonText: 'today'.tr,
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
          DateTime dateTime = dt;
          if(dt.hour == 23){
            var newDate = DateTime(dt.year,dt.month,dt.day + 1);
            dateTime = newDate;

          }else{
            dateTime = dt;
          }
          if(compareTowDays(dateTime, _currentDay)){
            return Center(

              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.mainGreenColor,width: 2),
                      color: AppColors.mainGreenColor,
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Center(child: Text(dateTime.day.toString(),style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),))),
            );
          }
          if(compareTowDays(dateTime, DateTime.now())){
            return Center(

              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.mainGreenColor,width: 2),
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Center(child: Text(dateTime.day.toString(),style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),))),
            );
          }



          if((controller.attendanceOfMonth.value.attendancesOfMonth[(dateTime.day-1) % controller.attendanceOfMonth.value.attendancesOfMonth.length].status == 'holiday') && DateTime.tryParse(controller.attendanceOfMonth.value.attendancesOfMonth[(dateTime.day-1) % controller.attendanceOfMonth.value.attendancesOfMonth.length].day ?? '')?.month == dateTime.month ){
            return Center(

              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.5),width: 2),
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Center(child: Text(dateTime.day.toString(),style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),))),
            );
          }

          if((controller.attendanceOfMonth.value.attendancesOfMonth[(dateTime.day-1) % controller.attendanceOfMonth.value.attendancesOfMonth.length].status == 'absent') && DateTime.tryParse(controller.attendanceOfMonth.value.attendancesOfMonth[(dateTime.day-1) % controller.attendanceOfMonth.value.attendancesOfMonth.length].day ?? '')?.month == dateTime.month ){
            return Center(

              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(1),width: 2),
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Center(child: Text(dateTime.day.toString(),style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),))),
            );
          }

          if((controller.attendanceOfMonth.value.attendancesOfMonth[(dateTime.day-1) % controller.attendanceOfMonth.value.attendancesOfMonth.length].status == 'weekEnd') && DateTime.tryParse(controller.attendanceOfMonth.value.attendancesOfMonth[(dateTime.day-1) % controller.attendanceOfMonth.value.attendancesOfMonth.length].day ?? '')?.month == dateTime.month ){
            return Center(

              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.withOpacity(1),width: 2),
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Center(child: Text(dateTime.day.toString(),style: const TextStyle(
                      fontWeight: FontWeight.bold
                  ),))),
            );
          }


          if(dateTime.month == controller.dateTime.month  ){
            return Center(

              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color:Colors.amber,
                      border: Border.all(color: Colors.white,width: 1),
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Center(child: Text(dateTime.day.toString(),style: const TextStyle(
                      fontWeight: FontWeight.bold
                  ),))),
            );
          }
          return null;
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
            color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),

      ),
    );
  }


  DateTime _currentDay = DateTime.now();

  bool compareTowDays(DateTime firstDate, DateTime secondDate){
    return firstDate.day == secondDate.day && firstDate.month == secondDate.month && firstDate.year == secondDate.year;
  }



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
