import 'package:clima/models/weather.dart';
import 'package:clima/services/location.dart';
import 'package:clima/utilities/service_dispatcher.dart';

import 'networking.dart';

const apiKey = 'dcd7b41735b97e94c3c463922348ed1d';
const unknownCondition = 1000;

abstract class IWeatherService implements IService {
  Future<WeatherModel?> refreshCurrentWeather() => Future(() => null);

  Future<WeatherModel?> refreshWeather(double latitude, double longitude) =>
      Future(() => null);
}

class WeatherService implements IWeatherService {
  final _locationService =
      ServiceDispatcher.instance.getService<ILocationService>();
  final _networkService =
      ServiceDispatcher.instance.getService<INetworkService>();

  @override
  Future<WeatherModel?> refreshCurrentWeather() async {
    var position = await _locationService.getCurrentPosition();

    if (position == null) return null;

    var weather = await refreshWeather(position.latitude, position.longitude);

    return weather;
  }

  @override
  Future<WeatherModel?> refreshWeather(
      double latitude, double longitude) async {
    var weatherData = await _getWeatherData(latitude, longitude);

    return _parseWeatherData(weatherData);
  }

  Future<dynamic> _getWeatherData(double latitude, double longitude) async {
    var uri = Uri.parse('https://api.openweathermap.org/data/2.5/weather?'
        'lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    return await _networkService.getData(uri);
  }

  WeatherModel? _parseWeatherData(dynamic weatherData) {
    int? condition = weatherData['weather']?[0]?['id'];
    double? temperature = weatherData['main']?['temp'];
    String? cityName = weatherData['name'];

    if (condition == null || temperature == null || cityName == null) {
      return null;
    }

    return WeatherModel(condition, temperature, cityName);
  }
}
