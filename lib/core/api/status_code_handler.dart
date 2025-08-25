import 'package:task/core/errors/failures.dart';

class StatusCodeHandler {
  static Failures handleStatusCode(int? statusCode, dynamic data) {
    switch (statusCode) {
      case 200:
      case 201:
        return ServerFailure("Success"); // Not really an error, but you can handle differently

      case 400:
        return ServerFailure("Bad Request: ${_extractMessage(data)}");
      case 401:
        return ServerFailure("Unauthorized: ${_extractMessage(data)}");
      case 403:
        return ServerFailure("Forbidden: ${_extractMessage(data)}");
      case 404:
        return ServerFailure("Not Found: ${_extractMessage(data)}");
      case 500:
        return ServerFailure("Internal Server Error: ${_extractMessage(data)}");
      case 502:
        return ServerFailure("Bad Gateway: ${_extractMessage(data)}");
      case 503:
        return ServerFailure("Service Unavailable: ${_extractMessage(data)}");
      default:
        return ServerFailure("Unexpected Error (code: $statusCode) - ${_extractMessage(data)}");
    }
  }

  static String _extractMessage(dynamic data) {
    if (data == null) return "No details";
    if (data is Map && data.containsKey("message")) {
      return data["message"];
    }
    return data.toString();
  }
}
