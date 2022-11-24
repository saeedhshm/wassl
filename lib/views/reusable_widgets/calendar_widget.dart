import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../helpers/constants/app_colors.dart';

class CalendarWidget extends StatefulWidget {

   CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Calendar(
        startOnMonday: true,
        weekDays: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
        // eventsList: _eventList,
        isExpandable: false,
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
        onDateSelected: (dateTime){
          // _currentDate = dateTime;

          setState(() {

          });
        },
        dayBuilder: (context,dateTime){
          // print('--->>>> ${dateTime.month}');
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

          if(dateTime.day == 5 || dateTime.day == 10 || dateTime.day == 15 || dateTime.day == 25  ){
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

          if(dateTime.month == _currentMonth.month && dateTime.month == _currentMonth.month ){
            return Center(

              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                  width: double.infinity,
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.red,width: 0),
                  //     borderRadius: BorderRadius.circular(100)
                  // ),
                  child: Center(child: Text(dateTime.day.toString(),style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),))),
            );
          }
          return null;
        },

        defaultOutOfMonthDayColor: Colors.green,
        defaultDayColor: Colors.grey,
        onMonthChanged: (dateTime){
          print('--->>>> ${dateTime.month}');
          _currentMonth = dateTime;
          setState(() {

          });
        },

        dayOfWeekStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),

      ),
    );
  }

  var colors = [
    Colors.red,
    Colors.green,
    Colors.amber,
    Colors.blue,
    Colors.brown
  ];

  final List<NeatCleanCalendarEvent> _eventList = [
    NeatCleanCalendarEvent('MultiDay Event A',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 12, 0),
        color: Colors.orange,
        isMultiDay: true),
    NeatCleanCalendarEvent('Allday Event B',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day - 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: Colors.pink,
        isAllDay: true),
    NeatCleanCalendarEvent('Normal Event D',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 17, 0),
        color: Colors.indigo),
  ];

  DateTime _currentMonth = DateTime.now();

  bool compareTowDays(DateTime firstDate, DateTime secondDate){
    return firstDate.day == secondDate.day && firstDate.month == secondDate.month && firstDate.year == secondDate.year;
  }


  DateTime _currentDate = DateTime.now();


}
