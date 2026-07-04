class OrderTypeEntity {
  final int id;
  final String name;

  const OrderTypeEntity({required this.id, required this.name});
}

class OrderStatusEntity {
  final int id;
  final String statusAr;
  final String statusEn;

  const OrderStatusEntity({
    required this.id,
    required this.statusAr,
    required this.statusEn,
  });
}

class OrderEntity {
  final int id;
  final int? employeeId;
  final int? displayOrdersTo;
  final String? type;
  final String? reason;
  final String? file;
  final String? createdAt;
  final String? updatedAt;
  final int? statusId;
  final String? orderName;
  final String? orderDate;
  final String? orderStatus;
  final String? pdfUrl;
  final int? activeResponsibleId;
  final OrderStatusEntity? status;
  final ResponsibleEmployeeEntity? responsibleEmployee;
  final OrderTypeEntity? orderType;
  final List<ConfirmationEntity>? confirmations;
  final String? hrComment;

  const OrderEntity({
    required this.id,
    this.employeeId,
    this.displayOrdersTo,
    this.type,
    this.reason,
    this.file,
    this.createdAt,
    this.updatedAt,
    this.statusId,
    this.orderName,
    this.orderDate,
    this.orderStatus,
    this.pdfUrl,
    this.activeResponsibleId,
    this.status,
    this.responsibleEmployee,
    this.orderType,
    this.confirmations,
    this.hrComment,
  });
}

class ConfirmationEntity {
  final int? id;
  final int? employeeId;
  final int? orderId;
  final int? status;
  final String? hrComment;
  final ResponsibleEmployeeEntity? responsibleEmployee;

  const ConfirmationEntity({
    this.id,
    this.employeeId,
    this.orderId,
    this.status,
    this.hrComment,
    this.responsibleEmployee,
  });
}

class ResponsibleEmployeeEntity {
  final int? id;
  final String? fullName;
  final String? fullNameEn;

  const ResponsibleEmployeeEntity({this.id, this.fullName, this.fullNameEn});
}

// Order type-specific entities
class HolidayOrderEntity {
  final int? id;
  final int? employeeId;
  final int? displayOrdersTo;
  final OrderTypeEntity? type;
  final String? holidayStart;
  final String? holidayEnd;
  final String? reason;
  final OrderStatusEntity? status;

  const HolidayOrderEntity({
    this.id,
    this.employeeId,
    this.displayOrdersTo,
    this.type,
    this.holidayStart,
    this.holidayEnd,
    this.reason,
    this.status,
  });
}

class LoanOrderEntity {
  final int? id;
  final int? employeeId;
  final OrderTypeEntity? type;
  final String? amount;
  final String? month;
  final String? monthlyInstallment;
  final String? reason;
  final OrderStatusEntity? status;

  const LoanOrderEntity({
    this.id,
    this.employeeId,
    this.type,
    this.amount,
    this.month,
    this.monthlyInstallment,
    this.reason,
    this.status,
  });
}

class PermissionOrderEntity {
  final int? id;
  final int? employeeId;
  final OrderTypeEntity? type;
  final String? date;
  final String? timeIn;
  final String? timeOut;
  final String? reason;
  final OrderStatusEntity? status;

  const PermissionOrderEntity({
    this.id,
    this.employeeId,
    this.type,
    this.date,
    this.timeIn,
    this.timeOut,
    this.reason,
    this.status,
  });
}

class LetterOrderEntity {
  final int? id;
  final int? employeeId;
  final OrderTypeEntity? type;
  final String? directedToAr;
  final String? directedToEn;
  final String? reason;
  final OrderStatusEntity? status;

  const LetterOrderEntity({
    this.id,
    this.employeeId,
    this.type,
    this.directedToAr,
    this.directedToEn,
    this.reason,
    this.status,
  });
}

class VisaOrderEntity {
  final int? id;
  final int? employeeId;
  final OrderTypeEntity? type;
  final OrderTypeEntity? visaTime;
  final String? requiredBefore;
  final String? ticket;
  final String? goDate;
  final String? backDate;
  final String? reason;
  final OrderStatusEntity? status;

  const VisaOrderEntity({
    this.id,
    this.employeeId,
    this.type,
    this.visaTime,
    this.requiredBefore,
    this.ticket,
    this.goDate,
    this.backDate,
    this.reason,
    this.status,
  });
}

class CustodyOrderEntity {
  final int? id;
  final int? employeeId;
  final OrderTypeEntity? type;
  final String? reason;
  final OrderStatusEntity? status;

  const CustodyOrderEntity({
    this.id,
    this.employeeId,
    this.type,
    this.reason,
    this.status,
  });
}

class FinancialExpenseEntity {
  final int? id;
  final int? employeeId;
  final String? name;
  final String? amount;
  final String? date;
  final String? description;
  final String? reason;
  final OrderStatusEntity? status;

  const FinancialExpenseEntity({
    this.id,
    this.employeeId,
    this.name,
    this.amount,
    this.date,
    this.description,
    this.reason,
    this.status,
  });
}

class OvertimeEntity {
  final int? id;
  final int? employeeId;
  final String? startTime;
  final String? endTime;
  final String? date;
  final String? reason;
  final OrderStatusEntity? status;

  const OvertimeEntity({
    this.id,
    this.employeeId,
    this.startTime,
    this.endTime,
    this.date,
    this.reason,
    this.status,
  });
}

class FingerprintCorrectionEntity {
  final int? id;
  final int? employeeId;
  final String? date;
  final String? time;
  final int? workingType;
  final String? reason;
  final OrderStatusEntity? status;

  const FingerprintCorrectionEntity({
    this.id,
    this.employeeId,
    this.date,
    this.time,
    this.workingType,
    this.reason,
    this.status,
  });
}

class ApologyEntity {
  final int? id;
  final int? employeeId;
  final String? date;
  final String? reason;
  final OrderStatusEntity? status;

  const ApologyEntity({
    this.id,
    this.employeeId,
    this.date,
    this.reason,
    this.status,
  });
}
