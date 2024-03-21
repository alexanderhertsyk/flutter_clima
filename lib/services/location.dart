import 'package:clima/utilities/service_dispatcher.dart';
import 'package:geolocator/geolocator.dart';

abstract class ILocationService implements IService {
  Future<Position?> getCurrentPosition();
}

class LocationService implements ILocationService {
  @override
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
