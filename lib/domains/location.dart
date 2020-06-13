class Location {
  double latitude;
  double longitude;

  Location({this.latitude, this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        latitude: double.parse(json['latitude']),
        longitude: double.parse(json['longitude']));
  }
}
