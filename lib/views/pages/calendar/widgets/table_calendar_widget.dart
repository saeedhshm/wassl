import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wassl/getx_controllers/calendar/calendar_controller.dart';
import 'package:wassl/views/pages/calendar/widgets/day_builder.dart';

import '../../../../helpers/constants/app_colors.dart';
import '../../../reusable_widgets/dot_widget.dart';

class TableCalendarWidget extends StatefulWidget {
  const TableCalendarWidget({super.key});

  @override
  State<TableCalendarWidget> createState() => _TableCalendarWidgetState();
}

class _TableCalendarWidgetState extends State<TableCalendarWidget> {

  final CalendarController controller = Get.find();
  var textDirection = TextDirection.rtl;
  DateTime? _selectedDay;


  @override
  Widget build(BuildContext context) {

    return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
        bottom: 15
    ),
      child: Obx(()=>TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(DateTime.now().year, 12, 31),
        focusedDay:controller.foCusedDate.value,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        holidayPredicate: (day) {
          return day.weekday == DateTime.friday ||
              day.weekday == DateTime.saturday;
        },
        locale: 'ar_SA',
        daysOfWeekHeight: 30,
        rowHeight: 42,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        calendarStyle: const CalendarStyle(
          outsideDaysVisible: true,
          // outsideTextStyle: TextStyle(color: Colors.red)
        ),
        calendarBuilders: CalendarBuilders(
          todayBuilder: (context, day, newDay) {

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.redAccent, width: 2),
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(100)),

                    child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              day.day.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                            Container(
                              height: 2,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: AppColors.mainGreenColor,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),

                          ],
                        ))),
              ],
            );

          },

          dowBuilder: (context, day) {

            return null;
          },

          weekNumberBuilder: (context,day){

            return Text('$day');
          },

          defaultBuilder: (context, day, newDay) {

            if(day.compareTo(DateTime.now() ) > 0) {
              return Center(
                child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color:Colors.amber,
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: Text(
                          day.day.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ))),
              );
            }

            if (checkDayAs('absent', day, controller)) {
              var prev = !checkDayAs('absent', DateTime(day.year,day.month,day.day - 1), controller);
              var next = !checkDayAs('absent', DateTime(day.year,day.month,day.day + 1), controller) ;

              return Container(

                // margin:  EdgeInsets.symmetric(horizontal: prev ? 4.0 : 0.0, vertical: 4),
                  margin: EdgeInsets.only(
                      left: (Get.locale?.languageCode == 'en' ? prev : next) ? 4.0 : 0.0,
                      right: (Get.locale?.languageCode == 'en' ? next : prev) ? 4.0 : 0.0,
                      top: 4,
                      bottom: 4
                  ),

                  //   width: 33,
                  height: 30,
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.white, width: 0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular( (Get.locale?.languageCode == 'en' ? prev : next) ? 100.0 : 0.0),
                      bottomLeft: Radius.circular((Get.locale?.languageCode == 'en' ? prev : next) ? 100.0 : 0.0),

                      topRight: Radius.circular((Get.locale?.languageCode == 'en' ? next : prev) ? 100.0 : 0.0),
                      bottomRight: Radius.circular((Get.locale?.languageCode == 'en' ? next : prev) ? 100.0 : 0.0),
                    ),
                    color: AppColors.orangeColorInCalend,),

                  child: Center(
                      child: Text(
                        day.day.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )));
            }

            //// holiday days
            if (checkDayAs('holiday', day, controller)) {
              var prev = !checkDayAs('holiday', DateTime(day.year,day.month,day.day - 1), controller);
              var next = !checkDayAs('holiday', DateTime(day.year,day.month,day.day + 1), controller) ;

              return Container(
                  margin: EdgeInsets.only(
                      left: (Get.locale?.languageCode == 'en' ? prev : next) ? 4.0 : 0.0,
                      right: (Get.locale?.languageCode == 'en' ? next : prev) ? 4.0 : 0.0,
                      top: 4,
                      bottom: 4
                  ),
                  //   width: 33,
                  height: 30,
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.white, width: 0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular( (Get.locale?.languageCode == 'en' ? prev : next) ? 100.0 : 0.0),
                      bottomLeft: Radius.circular((Get.locale?.languageCode == 'en' ? prev : next) ? 100.0 : 0.0),

                      topRight: Radius.circular((Get.locale?.languageCode == 'en' ? next : prev) ? 100.0 : 0.0),
                      bottomRight: Radius.circular((Get.locale?.languageCode == 'en' ? next : prev) ? 100.0 : 0.0),
                    ),
                    color: AppColors.mainGreenColor,),

                  child: Center(
                      child: Text(
                        day.day.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )));
            }

            if (checkMissedDay(day, controller)) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.redAccent, width: 2),
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(100)),

                      child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                day.day.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.black87),
                              ),
                              const DotWidget(
                                color: AppColors.redMissedDayColor,
                                size: 5,
                              )
                            ],
                          ))),
                ],
              );
            }

          },
          holidayBuilder: (context, day, newDay) {
            return Container(
                margin: const EdgeInsets.only(
                    left: 10.0,
                    right:  10.0,
                    top: 0,
                    bottom: 0
                ),
                //   width: 33,
                //   height: 33,
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.white, width: 0),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    bottomLeft: Radius.circular(0.0 ),

                    topRight: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0 ),
                  ),
                  color: AppColors.borderTextFieldColor,),

                child: Center(
                    child: Text(
                      day.day.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )));
          },

          headerTitleBuilder: (context, day) {
            return null;
          },

          selectedBuilder: (context, day, newDay) {

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    width: 33,
                    height: 33,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.white, width: 0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 0,
                            blurRadius: 7,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(100)),

                    child: Center(
                        child: Text(
                          day.day.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black87),
                        ))),
              ],
            );

          },

        ),
        availableCalendarFormats: const {CalendarFormat.month: 'Month'},
        currentDay: DateTime(2023,7,6),
        onRangeSelected: (first,second,third){

        },
        onPageChanged:(dateTime){
          controller.foCusedDate.value = dateTime;
          if(controller.dateTime.month != dateTime.month) {
            controller.dateTime = dateTime;

            controller.retrieveAttendanceData();
          }
          setState(() {

          });

        },

        // calendarStyle: const CalendarStyle(cellMargin : EdgeInsets.all(7.0),),
        daysOfWeekVisible: true,
        // rangeStartDay: DateTime(2023,7,10),
        // rangeEndDay: DateTime(2023,7,13),
        onDaySelected: (selectedDay,second){
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              controller.foCusedDate.value = selectedDay;
              controller.setSelectedDate(selectedDay);
            });

          }
        },

      )),

    );
  }
}
