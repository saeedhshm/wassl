class HolidayType {
  int? id;
  String? name;

  HolidayType({this.name,this.id});

}


final holidayTypes = [
  HolidayType(name: 'annual',id:1 ),
  HolidayType(name: 'un_paid' ,id: 2),
  HolidayType(name: 'death',id: 3),
  HolidayType(name: 'exams',id: 4),
  HolidayType(name: 'illness',id: 5),
];