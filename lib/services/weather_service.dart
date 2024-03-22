import 'package:clima/models/api_model.dart';
import 'package:clima/models/weather_model.dart';
import 'package:clima/services/location_service.dart';
import 'package:clima/utilities/service_dispatcher.dart';

import 'network_service.dart';

const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
const apiKey = 'dcd7b41735b97e94c3c463922348ed1d';
const unknownCondition = 1000;
const unexpectedError = 'Unexpected error!';

abstract class IWeatherService implements IService {
  Future<WeatherModel> getCurrentWeather() =>
      throw UnimplementedError('This is an interface!');

  Future<WeatherModel> getCityWeather(String city) =>
      throw UnimplementedError('This is an interface!');

  Future<WeatherModel> getPositionWeather(double latitude, double longitude) =>
      throw UnimplementedError('This is an interface!');
}

class WeatherService implements IWeatherService {
  final _locationService =
      ServiceDispatcher.instance.getService<ILocationService>();
  final _networkService =
      ServiceDispatcher.instance.getService<INetworkService>();

  @override
  Future<WeatherModel> getCurrentWeather() async {
    var position = await _locationService.getCurrentPosition();

    if (position == null) return WeatherModel.error("Can't locate device");

    var weather =
        await getPositionWeather(position.latitude, position.longitude);

    return weather;
  }

  @override
  Future<WeatherModel> getCityWeather(String city) async {
    var parameters = {'q': city};
    var weatherData = await _getWeatherData(parameters);

    return _parseWeatherData(weatherData);
  }

  @override
  Future<WeatherModel> getPositionWeather(
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

    var result = await _networkService.getData<dynamic>(uri);

    return result;
  }

  WeatherModel _parseWeatherData(ApiModel<dynamic> weatherData) {
    if (!weatherData.succeed) {
      var errorMessage = weatherData.errorMessage;
      int? code = int.tryParse(weatherData.response?['cod'] ?? '');

      if (code != null && code != 200) {
        errorMessage = weatherData.response?['message'];
      }

      return WeatherModel.error(errorMessage ?? unexpectedError);
    }

    int? condition = weatherData.response?['weather']?[0]?['id'];
    double? temperature = weatherData.response?['main']?['temp'];
    String? cityName = weatherData.response?['name'];

    if (condition == null || temperature == null || cityName == null) {
      return WeatherModel.error(unexpectedError);
    }

    return WeatherModel(
      condition: condition,
      temperature: temperature,
      cityName: cityName,
    );
  }
}
