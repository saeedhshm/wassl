class UserPosition {
  final double latitude;
  final double longitude;

  UserPosition({required this.latitude, required this.longitude});

  @override
  String toString() {
    // TODO: implement toString
    return "user position: latitude: $latitude, longitude: $longitude";
  }
}
