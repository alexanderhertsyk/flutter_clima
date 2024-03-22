import 'package:clima/models/api_model.dart';
import 'package:clima/utilities/service_dispatcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class INetworkService implements IService {
  Future<ApiModel<TResponse>> getData<TResponse>(Uri uri) async =>
      ApiModel(code: 400);
}

class NetworkService implements INetworkService {
  @override
  Future<ApiModel<TResponse>> getData<TResponse>(Uri uri) async {
    try {
      print(uri);
      var result = await http.get(uri);
      print(result.body);
      TResponse response = jsonDecode(result.body);

      return ApiModel(
        code: result.statusCode,
        response: response,
      );
    } catch (e) {
      print(e);
      return ApiModel(code: 500, errorMessage: e.toString());
    }
  }
}
