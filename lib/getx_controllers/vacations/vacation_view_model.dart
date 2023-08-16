import 'package:get/get.dart';

import '../../models/holidays/vacations.dart';

class VacationViewModel{
  Vacation vacation;
  VacationViewModel(this.vacation);

  String get countInDays{
    return '${vacation.count} ${'days'.tr}';
  }

  String get vacationTypeName{
    return '${vacation.type?.name}';
  }

  String get vacationStartsIn{
    return '${vacation.holidayStart}';
  }

  String get vacationEndsIn{
    return '${vacation.holidayEnd}';
  }
}