class IncomingEvent{
  int? id;
  String? title,startDate,endDate,startTime,endTime,details,location;

  IncomingEvent(
      {this.id,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.details,
        this.title,
      this.location});
}