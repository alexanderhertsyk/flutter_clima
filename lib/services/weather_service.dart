import 'package:clima/models/weather.dart';
import 'package:clima/services/location_service.dart';
import 'package:clima/utilities/service_dispatcher.dart';

import 'network_service.dart';

const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
const apiKey = 'dcd7b41735b97e94c3c463922348ed1d';
const unknownCondition = 1000;

abstract class IWeatherService implements IService {
  Future<WeatherModel?> getCurrentWeather() => Future(() => null);

  Future<WeatherModel?> getCityWeather(String city) => Future(() => null);

  Future<WeatherModel?> getPositionWeather(double latitude, double longitude) =>
      Future(() => null);
}

class WeatherService implements IWeatherService {
  final _locationService =
      ServiceDispatcher.instance.getService<ILocationService>();
  final _networkService =
      ServiceDispatcher.instance.getService<INetworkService>();

  @override
  Future<WeatherModel?> getCurrentWeather() async {
    var position = await _locationService.getCurrentPosition();

    if (position == null) return null;

    var weather =
        await getPositionWeather(position.latitude, position.longitude);

    return weather;
  }

  @override
  Future<WeatherModel?> getCityWeather(String city) async {
    var parameters = {'q': city};
    var weatherData = await _getWeatherData(parameters);

    return _parseWeatherData(weatherData);
  }

  @override
  Future<WeatherModel?> getPositionWeather(
      double latitude, double longitude) async {
    var parameters = {'lat': latitude, 'lon': longitude};
    var weatherData = await _getWeatherData(parameters);

    return _parseWeatherData(weatherData);
  }

  Future<dynamic> _getWeatherData(Map<String, Object> parameters) async {
    var parametersString =
        parameters.entries.map((e) => '&${e.key}=${e.value}').toList().join();
    var url = '$baseUrl?appid=$apiKey$parametersString&units=metric';
    var uri = Uri.parse(url);

    return await _networkService.getData(uri);
  }

  WeatherModel? _parseWeatherData(dynamic weatherData) {
    if (weatherData['cod'] != 200) return null;

    int? condition = weatherData['weather']?[0]?['id'];
    double? temperature = weatherData['main']?['temp'];
    String? cityName = weatherData['name'];

    if (condition == null || temperature == null || cityName == null) {
      return null;
    }

    return WeatherModel(condition, temperature, cityName);
  }
}
