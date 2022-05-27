import 'package:dio/dio.dart';

class NetworkClient {
  Dio _provideDio() => Dio()
    ..options.baseUrl = 'https://api.gametools.network/bf1/'
    ..options.connectTimeout = 300000
    ..options.receiveTimeout = 500000
    ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
    ..interceptors.add(LogInterceptor(responseBody: true));

  Future<dynamic> sendRequest(String path, Map<String, dynamic> queryParams) async {
    try {
      final response = await _provideDio().get(path, queryParameters: queryParams);
      return response.data;
    } on DioError catch (dioError) {
      return dioError.response?.data;
    } catch (e) {
      return null;
    }
  }
}
