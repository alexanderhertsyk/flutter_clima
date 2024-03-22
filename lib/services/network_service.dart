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
      print(uri);
      var response = await http.get(uri);
      print(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
