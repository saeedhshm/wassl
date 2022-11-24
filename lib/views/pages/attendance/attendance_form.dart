import 'package:flutter/material.dart';
import 'package:wassl/views/reusable_widgets/calendar_widget.dart';

import '../../reusable_widgets/main_appbar.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget("attendance_records",),
          Expanded(child: Padding(padding: EdgeInsets.symmetric(),
            child: CalendarWidget(),
          ))
        ],
      ),
    );
  }
}
