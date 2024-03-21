import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  static const _apiKey = 'dcd7b41735b97e94c3c463922348ed1d';

  static Future<dynamic> getWeather(double latitude, double longitude) async {
    var uri = Uri.parse('https://api.openweathermap.org/data/2.5/weather?'
        'lat=$latitude&lon=$longitude&appid=$_apiKey&units=metric');

    return await _getData(uri);
  }

  static Future<dynamic> _getData(Uri uri) async {
    try {
      var response = await http.get(uri);
      print(response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e);

      return null;
    }
  }
}
