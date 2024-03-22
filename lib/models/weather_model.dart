class WeatherModel {
  late String? _errorMessage;
  final int condition;
  final double temperature;
  final String cityName;
  bool get hasError => _errorMessage != null;
  String? get errorMessage => _errorMessage;

  static WeatherModel error(String message) =>
      WeatherModel._error(0, 0, '', message);

  WeatherModel(
      {required this.condition,
      required this.temperature,
      required this.cityName}) {
    _errorMessage = null;
  }

  WeatherModel._error(
    this.condition,
    this.temperature,
    this.cityName,
    this._errorMessage,
  );
}
