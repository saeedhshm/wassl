import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final int id;
  final String title;
  final String body;
  final bool doesRead;
  final String date;
  final String image;

  const NotificationEntity(
      {required this.id,
      required this.title,
      required this.body,
      required this.date,
      required this.image,
      required this.doesRead});

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, body];
}
