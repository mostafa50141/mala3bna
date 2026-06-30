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
    String extractMessage(dynamic response, String fallback) {
      if (response is Map<String, dynamic>) {
        // Shape 1: nested error object
        final error = response['error'];
        if (error is Map<String, dynamic>) {
          final msg = error['message'] as String?;
          if (msg != null && msg.isNotEmpty) return msg;
        }
        // Shape 2: DRF-style "detail" field
        final detail = response['detail'];
        if (detail is String && detail.isNotEmpty) return detail;
        // Shape 3: flat "message" field
        final msg = response['message'] as String?;
        if (msg != null && msg.isNotEmpty) return msg;
      }
      return fallback;
    }

    // Log the full error response so we can see what the backend rejects
    print('[ServerFailure] status=$statuscode  body=$response');
    if (statuscode == 400) {
      final msg = response is Map
          ? (response['message'] ?? response['detail'] ?? response.toString())
          : response?.toString();
      return ServerFailure(msg ?? 'Invalid request');
    } else if (statuscode == 401) {
      return ServerFailure(
        extractMessage(response, "Wrong email or password"),
      );
    } else if (statuscode == 403) {
      return ServerFailure(
        extractMessage(response, "Account not authorized"),
      );
    } else if (statuscode == 404) {
      return ServerFailure(extractMessage(response, "Account not found"));
    } else if (statuscode == 409) {
      return ServerFailure(
        extractMessage(response, "Email already registered"),
      );
    } else if (statuscode == 500) {
      return ServerFailure("Internal Server error, Please try later!");
    } else {
      return ServerFailure(
        extractMessage(response, "Something went wrong, Please try later!"),
      );
    }
  }
}
