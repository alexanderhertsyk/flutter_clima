import 'package:clima/utilities/service_dispatcher.dart';
import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart';

void main() {
  ServiceDispatcher.instance.init();
  runApp(const ClimaApp());
}

class ClimaApp extends StatelessWidget {
  const ClimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const LoadingScreen(),
    );
  }
}
