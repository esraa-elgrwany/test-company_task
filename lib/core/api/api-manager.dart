import 'package:dio/dio.dart';
import 'package:task/core/helper/company_manager/company_manager.dart';
import 'package:task/core/utils/constants.dart';

class ApiManager {
  final Dio dio;

  ApiManager({Dio? dioInstance}) : dio = dioInstance ?? Dio() {
    dio.options.headers = {
      "Accept": "*/*",
      "Content-Type": "multipart/form-data",
    };
  }

  Options _options({Map<String, dynamic>? extraHeaders}) {
    return Options(
      headers: {
        "Accept": "*/*",
        "Content-Type": "multipart/form-data",
        ...?extraHeaders,
      },
    );
  }
  String get _baseUrl => CompanyManager().baseUrl;

  Future<Response> getData(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(
        _baseUrl +endPoint,
        queryParameters: queryParameters,
        options: _options(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postData(
    String endPoint, {
    FormData? body,
    Map<String, dynamic>? extraHeaders,
  }) async {
    try {
      return await dio.post(
        _baseUrl +endPoint,
        data: body,
        options: _options(extraHeaders: extraHeaders),
      );
    } catch (e) {
      rethrow;
    }
  }

}
