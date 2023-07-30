import 'event.dart';

class IncomingEvents {
  bool? success;
  List<IncomingEvent> events = <IncomingEvent>[];

  IncomingEvents();

  IncomingEvents.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['covenants'] != null) {

      json['covenants'].forEach((v) {
        events.add(IncomingEvent.fromJson(v));
      });
    }
  }

}

