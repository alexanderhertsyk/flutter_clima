class WeatherModel {
  late bool _isEmpty;
  final int condition;
  final double temperature;
  final String cityName;
  bool get isEmpty => _isEmpty;

  static WeatherModel get empty => WeatherModel._empty(0, 0, '');

  WeatherModel(this.condition, this.temperature, this.cityName) {
    _isEmpty = false;
  }

  WeatherModel._empty(this.condition, this.temperature, this.cityName) {
    _isEmpty = true;
  }
}
