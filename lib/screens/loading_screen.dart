import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/networking.dart';
import '../services/location.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    updateWeather();
  }

  Future updateWeather() async {
    var position = await Location().getCurrentPosition();

    if (position == null) return;

    var weather =
        await NetworkHelper.getWeather(position.latitude, position.longitude);

    if (weather == null) return;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(
                  weather: weather,
                )));
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
