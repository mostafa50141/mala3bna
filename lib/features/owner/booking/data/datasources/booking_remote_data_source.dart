import 'package:mala3bna/core/network/dio_client.dart';
import 'package:mala3bna/core/network/api_endpoints.dart';
import 'package:mala3bna/features/owner/booking/data/models/booking_model.dart';

abstract class BookingRemoteDataSource {
  Future<List<BookingModel>> fetchBookings();
  Future<BookingModel> acceptBooking(String id);
  Future<BookingModel> declineBooking(String id);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final DioClient dioClient;

  BookingRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<BookingModel>> fetchBookings() async {
    final response = await dioClient.get(ApiEndpoints.bookings);
    print('[Bookings] Raw fetch response type: ${response.runtimeType}');

    final List<dynamic> data;
    if (response is List) {
      data = response;
    } else if (response is Map && response.containsKey('results')) {
      data = response['results'] as List<dynamic>;
    } else {
      print('[Bookings] Unexpected response structure: $response');
      data = [];
    }

    return data.map((json) => BookingModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<BookingModel> acceptBooking(String id) async {
    try {
      // Some backends require a body; try with empty body first.
      // If 400 persists, backend may need: data: {'status': 'accepted'}
      final response = await dioClient.post(
        ApiEndpoints.bookingAccept(id),
        data: {'status': 'accepted'},
      );
      print('[Bookings] accept response: $response');
      if (response == null || response == '') {
        return BookingModel.fromJson({});
      }
      return BookingModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      print('[Bookings] acceptBooking Error: $e');
      rethrow;
    }
  }

  @override
  Future<BookingModel> declineBooking(String id) async {
    try {
      final response = await dioClient.post(
        ApiEndpoints.bookingDecline(id),
        data: {'status': 'declined'},
      );
      print('[Bookings] decline response: $response');
      if (response == null || response == '') {
        return BookingModel.fromJson({});
      }
      return BookingModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      print('[Bookings] declineBooking Error: $e');
      rethrow;
    }
  }
}
