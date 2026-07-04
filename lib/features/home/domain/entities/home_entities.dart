class AdEntity {
  final int? id;
  final String? title;
  final String? description;
  final String? image;

  const AdEntity({this.id, this.title, this.description, this.image});
}

class EventEntity {
  final int? id;
  final String? title;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? location;

  const EventEntity({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.location,
  });
}

class HomeDataEntity {
  final List<AdEntity>? ads;
  final List<EventEntity>? events;

  const HomeDataEntity({this.ads, this.events});
}
