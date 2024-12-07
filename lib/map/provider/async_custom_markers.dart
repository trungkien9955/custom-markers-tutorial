import 'package:custom_markers_tutorial/main.dart';
import 'package:custom_markers_tutorial/map/entitties.dart';
import 'package:custom_markers_tutorial/map/repo/map_repo.dart';
import 'package:custom_markers_tutorial/utilities/map/marker_generator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'async_custom_markers.g.dart';

@riverpod
Future<List<Marker>> asyncCustomMarkers(AsyncCustomMarkersRef ref) async {
  List<Marker> markerList = [];

  final response = await MapRepo().fetchNearbyUsers();

  if (response.statusCode == 200) {
    // print(response.data['data']);
    List<User> userList = List<User>.from(
        response.data['data'].map((item) => User.fromMap(item)));
    if (userList.isNotEmpty) {
      List<MarkerItem> list = [];

      await Future.forEach(userList, (User item) async {
        await MarkerGenerator()
            .createCustomMarker(item.photoUrl, size: 60)
            .then((icon) {
          MarkerItem markerDataEntity = MarkerItem(
              markerId: item.id,
              lat: item.position.lat,
              lng: item.position.lng,
              title: item.name,
              snippet: '',
              icon: icon);
          list.add(markerDataEntity);
        });
      });

      for (var i = 0; i < list.length; i++) {
        Marker marker = Marker(
            markerId: MarkerId(list[i].markerId),
            zIndex: 2,
            position: LatLng(list[i].lat, list[i].lng),
            icon: list[i].icon,
            onTap: () {
              navigatorKey.currentState?.pushNamed('/profile', arguments: {
                'userId': list[i].markerId,
                'name': list[i].title
              });
            });
        markerList.add(marker);
      }
    }
  }
  print(markerList);
  return markerList;
}
