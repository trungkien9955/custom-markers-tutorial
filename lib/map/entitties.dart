import 'package:google_maps_flutter/google_maps_flutter.dart';

class Position {
  double lat;
  double lng;
  Position({required this.lat, required this.lng});

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class User {
  String id;
  String name;
  UserPosition position;
  String photoUrl;
  User({
    required this.id,
    required this.name,
    required this.position,
    required this.photoUrl,
  });
  factory User.fromMap(Map<String, dynamic> map) => User(
        id: map['id'],
        name: map['name'],
        position: UserPosition(
            lat: map['position']['lat'], lng: map['position']['long']),
        photoUrl: map['photoUrl'],
      );
}

class UserPosition {
  double lat;
  double lng;
  UserPosition({required this.lat, required this.lng});
}

class MarkerItem {
  String markerId;
  double lat;
  double lng;
  String title;
  String snippet;
  BitmapDescriptor icon;
  MarkerItem({
    required this.markerId,
    required this.lat,
    required this.lng,
    required this.title,
    required this.snippet,
    required this.icon,
  });
}
