import 'AllOrders.dart';
import 'order_status.dart';
import 'order_type.dart';

class OvertimeData implements Order{
  int? id;
  int? employeeId;
  int? displayOrdersTo;
  String? startTime;
  String? endTime;
  String? date;
  String? _reason;
  @override
  Status? status;
  String? _file;
  String? createdAt;
  String? updatedAt;
  @override
  OrderType? type;
  @override
  int? activeResponsibleId;
  @override
  ResponsibleEmployee? nameEmployee;
  @override
  List<Confirmation>? confirmation;

  @override
  var hrComment;
  OvertimeData(
      {this.id,
        this.employeeId,
        this.displayOrdersTo,
        this.startTime,
        this.endTime,
        this.date,
        this.status,
        this.createdAt,
        this.updatedAt});

  OvertimeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pdfUrl = json['pdf_url'];
    employeeId = json['employee_id'];
    displayOrdersTo = json['display_orders_to'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    date = json['date'];
    _reason = json['reason'];
    status =
    json['status'] != null ? Status.fromJson(json['status']) : null;
    _file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    hrComment = json['hr_comment'];
    activeResponsibleId = json['active_responsible_id'];
    if (json['confirmation'] != null) {
      confirmation = <Confirmation>[];
      json['confirmation'].forEach((v) {
        confirmation!.add(Confirmation.fromJson(v));
      });
    }
  }



  @override
  String get file => _file ?? '';

  @override
  // TODO: implement orderType
  String get orderName => 'OvertimeData';
  @override
  // TODO: implement orderDate
  String get orderDate {
    return (date ?? '').split('T')[0];
  }

  @override
  // TODO: implement orderStatus
  String get orderStatus => status == null  ? 'not_confirmed' : '${status?.statusAr}';


  @override
  // TODO: implement reason
  String get reason => (_reason == null || _reason == '') ? 'unspecified' : (_reason ?? '');

  @override
  // TODO: implement orderStatus
  int get statusID => status == null  ? 1 : status?.id ?? 1;

  @override
  // TODO: implement orderStatus
  int get orderID =>  id ?? -1;

  @override
  String? pdfUrl;

}