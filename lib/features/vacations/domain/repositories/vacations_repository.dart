import 'package:wassl/core/error/result.dart';

class VacationBalanceEntity {
  final String? openingVacationsCount;
  final String? usedVacationsCount;
  final String? availableVacationsCount;
  final String? discountVacationsCount;
  final String? sickVacationsCount;
  final String? unpaidVacationsCount;

  const VacationBalanceEntity({
    this.openingVacationsCount,
    this.usedVacationsCount,
    this.availableVacationsCount,
    this.discountVacationsCount,
    this.sickVacationsCount,
    this.unpaidVacationsCount,
  });
}

class VacationHistoryEntity {
  final int? id;
  final String? type;
  final String? holidayStart;
  final String? holidayEnd;
  final int? count;
  final String? typeOfOrder;

  const VacationHistoryEntity({
    this.id,
    this.type,
    this.holidayStart,
    this.holidayEnd,
    this.count,
    this.typeOfOrder,
  });
}

class VacationsEntity {
  final VacationBalanceEntity? balance;
  final List<VacationHistoryEntity>? incoming;
  final List<VacationHistoryEntity>? previous;

  const VacationsEntity({this.balance, this.incoming, this.previous});
}

abstract class VacationsRepository {
  Future<Result<VacationsEntity>> getVacations();
}
