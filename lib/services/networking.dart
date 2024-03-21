import 'package:clima/utilities/service_dispatcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class INetworkService implements IService {
  Future<dynamic> getData(Uri uri) async => null;
}

class NetworkService implements INetworkService {
  @override
  Future<dynamic> getData(Uri uri) async {
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
