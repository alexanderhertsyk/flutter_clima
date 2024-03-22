import 'package:clima/models/weather.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather_service.dart';
import 'package:clima/utilities/service_dispatcher.dart';
import 'package:clima/utilities/weather_helper.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

const kWeatherErrorTemperature = '-.-';
const kWeatherErrorCondition = '🤷‍';
const kWeatherErrorSuggestion = 'Unable to get weather data';

class LocationScreen extends StatefulWidget {
  const LocationScreen(this.weather, {super.key});
  final WeatherModel? weather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final IWeatherService _weatherService =
      ServiceDispatcher.instance.getService<IWeatherService>();
  String _temperature = '', _condition = '', _suggestion = '';

  @override
  void initState() {
    super.initState();

    _setWeather(widget.weather);
  }

  Future _refreshCurrentWeather() async {
    var weather = await _weatherService.getCurrentWeather();
    _setWeather(weather);
  }

  void _setWeather(WeatherModel? weather) => setState(() {
        if (weather != null) {
          _temperature = weather.temperature.toStringAsFixed(1);
          _condition = WeatherHelper.getConditionIcon(weather.condition);
          _suggestion = WeatherHelper.getSuggestion(
              weather.temperature, weather.cityName);
        } else {
          _temperature = kWeatherErrorTemperature;
          _condition = kWeatherErrorCondition;
          _suggestion = kWeatherErrorSuggestion;
        }
      });

  Future _openCityPage(BuildContext context) async {
    var city = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CityScreen()));

    if (city != null) {
      var weather = await _weatherService.getCityWeather(city);
      _setWeather(weather);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () => _refreshCurrentWeather(),
                    icon: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _openCityPage(context),
                    icon: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$_temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      _condition,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  _suggestion,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
