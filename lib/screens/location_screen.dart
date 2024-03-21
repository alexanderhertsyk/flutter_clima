import 'package:clima/models/weather.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/service_dispatcher.dart';
import 'package:clima/utilities/weather_helper.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.weather, {super.key});
  WeatherModel weather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final IWeatherService _weatherService =
      ServiceDispatcher.instance.getService<IWeatherService>();
  double _temp = 0;
  int _condition = 0;
  String _cityName = '';

  @override
  void initState() {
    super.initState();

    updateUI();
  }

  void updateUI() {
    _temp = widget.weather.temperature;
    _condition = widget.weather.condition;
    _cityName = widget.weather.cityName;
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
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
                      '${_temp.toStringAsFixed(1)}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      WeatherHelper.getConditionIcon(_condition),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '${WeatherHelper.getSuggestion(_temp)} in $_cityName!',
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
