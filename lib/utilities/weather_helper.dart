class WeatherHelper {
  WeatherHelper._internal();

  static String getSuggestion(double temp) => switch (temp) {
        > 25 => 'It\'s 🍦 time',
        > 20 => 'Time for shorts and 👕',
        < 10 => 'You\'ll need 🧣 and 🧤',
        _ => 'Bring a 🧥 just in case'
      };

  static String getConditionIcon(int condition) => switch (condition) {
        < 300 => '🌩',
        < 400 => '🌧',
        < 700 => '☃️',
        < 800 => '🌫',
        == 800 => '☀️',
        <= 804 => '☁️',
        _ => '🤷‍'
      };
}
