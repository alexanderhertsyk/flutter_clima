import 'package:geolocator/geolocator.dart';

class Location {
  Future<Position?> getCurrentPosition() async {
    try {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      return position;
    } catch (e) {
      print(e);

      return null;
    }
  }
}
