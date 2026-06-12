import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/core/utils/api_server.dart';
import 'package:mala3bna/features/player/courts_booking/data/models/booking_model.dart';
import 'package:mala3bna/features/player/courts_booking/data/repos/booking_repo.dart';

class BookingRepoImpl implements BookingRepo {
  final ApiService apiService;
  BookingRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, BookingModel>> createBooking({
    required int fieldId,
    required String bookingDate,
    required String startTime,
    required String endTime,
    String? notes,
  }) async {
    try {
      var response = await apiService.post(
        endPoint: 'bookings/',
        body: {
          'field': fieldId,
          'booking_date': bookingDate,
          'start_time': startTime,
          'end_time': endTime,
          if (notes != null) 'notes': notes,
        },
      );
      return right(BookingModel.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookingModel>>> getBookings() async {
    try {
      var response = await apiService.get(endPoint: 'bookings/');
      final List<dynamic> data = response is List
          ? response
          : (response['results'] as List<dynamic>? ?? []);
      return right(
        data.map((json) => BookingModel.fromJson(json)).toList(),
      );
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelBooking({required int bookingId}) async {
    try {
      await apiService.delete(endPoint: 'bookings/$bookingId/');
      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
