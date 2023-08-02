import 'package:flutter/material.dart';
// import 'package:flutter_neat_and_clean_calendar/date_picker_config.dart';
// import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/calendar/calendar_controller.dart';


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
//       child: Directionality(
//         // textDirection:Get.locale?.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
//         textDirection: TextDirection.rtl,
//         child: Calendar(
//           // startOnMonday: false,
//           // weekDays: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
//           // eventsList: _eventList,
//           weekDays:  const ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
//           // weekDays:  ['Sat'.tr, 'Sun'.tr, 'Mon'.tr, 'Tue'.tr, 'Wed'.tr, 'Thu'.tr, 'Fri'.tr],
//           isExpandable: false,
//
//           initialDate: controller.dateTime,
//           datePickerConfig: DatePickerConfig(
//             initialDate: controller.dateTime
//           ),
//           eventDoneColor: Colors.green,
//           selectedColor: Colors.pink,
//           selectedTodayColor: Colors.red,
//           todayColor: Colors.blue,
//           eventColor: null,
//           locale: 'ar_SA',
//           // todayButtonText: 'Heute',
//           // allDayEventText: 'Ganztägig',
//           multiDayEndText: 'Ende',
//           isExpanded: true,
//           // expandableDateFormat: '',
//           // datePickerType: DatePickerType.date,
//           hideBottomBar: true,
//           // todayButtonText: ''.tr,
//           todayButtonText: '',
//           onRangeSelected:(value){
//
//             println('onRangeSelected $value');
//           } ,
//
//           onDateSelected: (dt){
//             DateTime dateTime = dt;
//             if(dt.hour == 23){
//               var newDate = DateTime(dt.year,dt.month,dt.day + 1);
//               dateTime = newDate;
//
//             }else{
//               dateTime = dt;
//             }
//             _currentDay = dateTime;
//
//             controller.setSelectedDate(dateTime);
//             setState(() {
//
//             });
//           },
//           dayBuilder: (context,dt){
//             DateTime dateTime = dt;
//
//             ///to get current day
//             ///
//
//
//             if (dt.hour == 23) {
//               var newDate = DateTime(dt.year, dt.month, dt.day + 1);
//               dateTime = newDate;
//             }
//             else {
//               dateTime = dt;
//             }
//
//             var weekDay = dateTime.weekday;
//             var dd = controller
//                 .attendanceOfMonth
//                 .value
//                 .attendancesOfMonth[(dateTime.day - 1) %
//                 controller.attendanceOfMonth.value.attendancesOfMonth.length]
//                 .status == 'weekEnd' && dateTime.weekday > 4 ? dateTime.weekday : -1;
//
//
//
//             weekDays.add(dd);
//
//             var day = dateTime.day.toString().replaceToArabicNumbers;
//             println('=-=-=->>>>>> dateTime.weekday $day');
//             /// week end days
//             for(var i in weekDays){
//               if(dateTime.weekday == i){
//
//                 return Container(
//                     margin: const EdgeInsets.only(
//                         left: 10.0,
//                         right:  10.0,
//                         top: 0,
//                         bottom: 0
//                     ),
//                     //   width: 33,
//                     //   height: 33,
//                     decoration: BoxDecoration(
//                       // border: Border.all(color: Colors.white, width: 0),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(0.0),
//                         bottomLeft: Radius.circular(0.0 ),
//
//                         topRight: Radius.circular(0.0),
//                         bottomRight: Radius.circular(0.0 ),
//                       ),
//                       color: AppColors.borderTextFieldColor,),
//
//                     child: Center(
//                         child: Text(
//                           dateTime.day.toString(),
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold, color: Colors.white),
//                         )));
//               }
//             }
//
//
//             // Other months days
//             if(DateTime.tryParse(controller
//                 .attendanceOfMonth
//                 .value
//                 .attendancesOfMonth[(dateTime.day - 1) %
//                 controller.attendanceOfMonth.value.attendancesOfMonth
//                     .length]
//                 .day ??
//                 '')
//                 ?.month !=
//                 dateTime.month) {
//               return Center(
//                 child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       // color:Colors.amber,
//                         border: Border.all(color: Colors.white, width: 1),
//                         borderRadius: BorderRadius.circular(100)),
//                     child: Center(
//                         child: Text(
//                           day.replaceToArabicNumbers,
//                           style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.grey),
//                         ))),
//               );
//             }
//
//             /// return selected day in current month
//             if (compareTowDays(dateTime, _currentDay)) {
//               return Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
//                       width: 33,
//                       height: 33,
//                       decoration: BoxDecoration(
//                         // border: Border.all(color: Colors.white, width: 0),
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.4),
//                               spreadRadius: 0,
//                               blurRadius: 7,
//                               offset: Offset(0, 0), // changes position of shadow
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(100)),
//
//                       child: Center(
//                           child: Text(
//                             day,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold, color: Colors.black87),
//                           ))),
//                 ],
//               );
//             }
//
//             /// to return today's day
//             if (compareTowDays(dateTime, DateTime.now())) {
//               return Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
//                       width: 35,
//                       height: 35,
//                       decoration: BoxDecoration(
//                         // border: Border.all(color: Colors.redAccent, width: 2),
//                           color: Colors.white,
//
//                           borderRadius: BorderRadius.circular(100)),
//
//                       child: Center(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 day,
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold, color: Colors.black87),
//                               ),
//                               Container(
//                                 height: 2,
//                                 width: 20,
//                                 decoration: BoxDecoration(
//                                     color: AppColors.mainGreenColor,
//                                     borderRadius: BorderRadius.circular(10)
//                                 ),
//                               ),
//
//                             ],
//                           ))),
//                 ],
//               );
//             }
//
//             /// week end days
//             if (checkDayAs('weekEnd', dateTime, controller)) {
//               return Container(
//                   margin: EdgeInsets.only(
//                       left: 10.0,
//                       right:  10.0,
//                       top: 0,
//                       bottom: 0
//                   ),
//                   //   width: 33,
//                   //   height: 33,
//                   decoration: BoxDecoration(
//                     // border: Border.all(color: Colors.white, width: 0),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(0.0),
//                       bottomLeft: Radius.circular(0.0 ),
//
//                       topRight: Radius.circular(0.0),
//                       bottomRight: Radius.circular(0.0 ),
//                     ),
//                     color: AppColors.borderTextFieldColor,),
//
//                   child: Center(
//                       child: Text(
//                         day,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.white),
//                       )));
//             }
//
//             // future days
//             if (dateTime.month > DateTime.now().month || (dateTime.month == DateTime.now().month && dateTime.day > DateTime.now().day) )
//             {
//               return Center(
//                 child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       // color:Colors.amber,
//                         border: Border.all(color: Colors.white, width: 1),
//                         borderRadius: BorderRadius.circular(100)),
//                     child: Center(
//                         child: Text(
//                           day,
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ))),
//               );
//             }
//
//             // holiday days
//             if (checkDayAs('holiday', dateTime, controller)) {
//               var prev = !checkDayAs('holiday', DateTime(dateTime.year,dateTime.month,dateTime.day - 1), controller);
//               var next = !checkDayAs('holiday', DateTime(dateTime.year,dateTime.month,dateTime.day + 1), controller) ;
//
//               return Container(
//                   margin: EdgeInsets.only(
//                       left: prev ? 4.0 : 0.0,
//                       right: next ? 4.0 : 0.0,
//                       top: 4,
//                       bottom: 4
//                   ),
//                   //   width: 33,
//                   //   height: 33,
//                   decoration: BoxDecoration(
//                     // border: Border.all(color: Colors.white, width: 0),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(prev ? 100.0 : 0.0),
//                       bottomLeft: Radius.circular(prev ? 100.0 : 0.0),
//
//                       topRight: Radius.circular(next ? 100.0 : 0.0),
//                       bottomRight: Radius.circular(next ? 100.0 : 0.0),
//                     ),
//                     color: AppColors.mainGreenColor,),
//
//                   child: Center(
//                       child: Text(
//                         day,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.white),
//                       )));
//             }
//
//             /// absent days
//             else if (checkDayAs('absent', dateTime, controller)) {
//               var prev = checkDayAs('absent', DateTime(dateTime.year,dateTime.month,dateTime.day - 1), controller);
//               var next = checkDayAs('absent', DateTime(dateTime.year,dateTime.month,dateTime.day + 1), controller) || (dateTime.day +1 == DateTime.now().day) ;
//
//               return Container(
//
//                 // margin:  EdgeInsets.symmetric(horizontal: prev ? 4.0 : 0.0, vertical: 4),
//                   margin: EdgeInsets.only(
//                       left: prev ? 4.0 : 0.0,
//                       right: next ? 4.0 : 0.0,
//                       top: 4,
//                       bottom: 4
//                   ),
//
//                   //   width: 33,
//                   //   height: 33,
//                   decoration: BoxDecoration(
//                     // border: Border.all(color: Colors.white, width: 0),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(prev ? 100.0 : 0.0),
//                       bottomLeft: Radius.circular(prev ? 100.0 : 0.0),
//
//                       topRight: Radius.circular(next ? 100.0 : 0.0),
//                       bottomRight: Radius.circular(next ? 100.0 : 0.0),
//                     ),
//                     color: AppColors.orangeColorInCalend,),
//
//                   child: Center(
//                       child: Text(
//                         day,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.white),
//                       )));
//             }
//
//
//
//             // missed days - lost fingerprints
//             else if (checkMissedDay(dateTime, controller)) {
//               return Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
//                       width: 35,
//                       height: 35,
//                       decoration: BoxDecoration(
//                         // border: Border.all(color: Colors.redAccent, width: 2),
//                           color: Colors.white,
//
//                           borderRadius: BorderRadius.circular(100)),
//
//                       child: Center(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 day,
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold, color: Colors.black87),
//                               ),
//                               const DotWidget(
//                                 color: AppColors.redMissedDayColor,
//                                 size: 5,
//                               )
//                             ],
//                           ))),
//                 ],
//               );
//             }
//
//             // other days
//             else if (dateTime.month == controller.dateTime.month) {
//               return Center(
//                 child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
// // color:Colors.amber,
//                         border: Border.all(color: Colors.white, width: 1),
//                         borderRadius: BorderRadius.circular(100)),
//                     child: Center(
//                         child: Text(
//                           day,
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ))),
//               );
//             }
//
//           },
//
//           defaultOutOfMonthDayColor: Colors.green,
//           defaultDayColor: Colors.grey,
//           onMonthChanged: (dateTime){
//
//
//
//             if(controller.dateTime.month != dateTime.month) {
//               controller.dateTime = dateTime;
//               controller.retrieveAttendanceData();
//             }
//             setState(() {
//
//             });
//           },
//           dayOfWeekStyle: const TextStyle(
//               color: AppColors.lightGreyTextColor, fontWeight: FontWeight.w800, fontSize: 11),
//
//         ),
//       ),
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
