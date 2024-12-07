import 'package:custom_markers_tutorial/map/entitties.dart';
import 'package:dio/dio.dart';

class MapRepo {
  MapRepo();
  Future<Response> fetchNearbyUsers() async {
    Position position =
        Position(lat: 21.00126273562229, lng: 105.83141060525638);
    String api = 'http://192.168.100.229:3001/map/nearby-persons';
    Response response = await Dio()
        .get(api, queryParameters: {'lat': position.lat, 'long': position.lng});
    return response;
  }
}
