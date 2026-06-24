import 'package:dio/dio.dart';

abstract class Failure {
  final String? errmessage;
  const Failure({this.errmessage});

  @override
  String toString() => errmessage ?? 'Unknown error';
}

class ServerFailure extends Failure {
  ServerFailure(String? errmessage) : super(errmessage: errmessage);

  @override
  String toString() => errmessage ?? 'Server error';

  factory ServerFailure.fromDioError(DioException dioexception) {
    switch (dioexception.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure("Connection Timeout with ApiServer");
      case DioExceptionType.sendTimeout:
        return ServerFailure("Send Timeout with ApiServer");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("Receive Timeout with ApiServer");
      case DioExceptionType.badResponse:
        {
          return ServerFailure.fromResponse(
            dioexception.response?.statusCode ?? 0,
            dioexception.response?.data,
          );
        }
      case DioExceptionType.cancel:
        return ServerFailure("Request to ApiServer was cancelled");
      case DioExceptionType.connectionError:
        return ServerFailure(
          "Connection to ApiServer failed due to internet connection",
        );
      case DioExceptionType.unknown:
        return ServerFailure("Unexpected error occurred");
      default:
        return ServerFailure("Something went wrong");
    }
  }

  factory ServerFailure.fromResponse(int? statuscode, dynamic response) {
    // Log the full error response so we can see what the backend rejects
    print('[ServerFailure] status=$statuscode  body=$response');
    if (statuscode == 400) {
      final msg = response is Map
          ? (response['message'] ?? response['detail'] ?? response.toString())
          : response?.toString();
      return ServerFailure(msg ?? 'Invalid request');
    } else if (statuscode == 401) {
      return ServerFailure(response["message"] ?? "Wrong email or password");
    } else if (statuscode == 403) {
      return ServerFailure(response["message"] ?? "Account not authorized");
    } else if (statuscode == 404) {
      return ServerFailure(response["message"] ?? "Account not found");
    } else if (statuscode == 409) {
      return ServerFailure(response["message"] ?? "Email already registered");
    } else if (statuscode == 500) {
      return ServerFailure("Internal Server error, Please try later!");
    } else {
      return ServerFailure("Something went wrong, Please try later!");
    }
  }
}
