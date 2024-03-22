import 'package:clima/services/location_service.dart';
import 'package:clima/services/network_service.dart';
import 'package:clima/services/weather_service.dart';

abstract class IService {}

class ServiceDispatcher {
  static final List<IService> _services = [];
  static final ServiceDispatcher instance = ServiceDispatcher._internal();

  // TODO: add lazy loading
  ServiceDispatcher._internal();

  void init() {
    _services.add(LocationService());
    _services.add(NetworkService());
    _services.add(WeatherService());
  }

  TService getService<TService extends IService>() =>
      _services.whereType<TService>().first;
}
