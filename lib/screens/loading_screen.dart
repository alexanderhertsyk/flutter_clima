import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/service_dispatcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final _weatherService =
      ServiceDispatcher.instance.getService<IWeatherService>();

  @override
  void initState() {
    super.initState();

    updateWeather();
  }

  Future updateWeather() async {
    var weather = await _weatherService.refreshCurrentWeather();

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LocationScreen(weather)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCubeGrid(
            size: 100,
            itemBuilder: (context, int index) => DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.blue : Colors.lightBlueAccent,
                  ),
                )),
      ),
    );
  }
}
