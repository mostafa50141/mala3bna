import 'package:mala3bna/features/owner/booking/presentation/model/booking_request_model.dart';

/// Simulates a remote data source. Replace with real API calls later.
class BookingRepository {
  Future<List<BookingRequest>> fetchBookings() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      BookingRequest(
        id: '1',
        name: 'Karim Adel',
        sport: 'Padel',
        duration: '1.5 Hours',
        dateTime: 'Today, 06:00 PM',
        price: 'EGP 450',
        status: BookingStatus.pending,
        avatar: 'https://i.pravatar.cc/150?img=1',
      ),
      BookingRequest(
        id: '2',
        name: 'Youssef El-Masry',
        sport: 'Football',
        duration: '2 Hours',
        dateTime: 'Tomorrow, 08:00 PM',
        price: 'EGP 600',
        status: BookingStatus.pending,
        avatar: 'https://i.pravatar.cc/150?img=2',
      ),
      BookingRequest(
        id: '3',
        name: 'Sara Mohamed',
        sport: 'Tennis',
        duration: '1 Hour',
        dateTime: 'Today, 04:00 PM',
        price: 'EGP 300',
        status: BookingStatus.approved,
        avatar: 'https://i.pravatar.cc/150?img=3',
      ),
      BookingRequest(
        id: '4',
        name: 'Omar Hassan',
        sport: 'Padel',
        duration: '2 Hours',
        dateTime: 'Thu, 10:00 AM',
        price: 'EGP 600',
        status: BookingStatus.pending,
        avatar: 'https://i.pravatar.cc/150?img=4',
      ),
      BookingRequest(
        id: '5',
        name: 'Nour Khaled',
        sport: 'Football',
        duration: '1.5 Hours',
        dateTime: 'Fri, 05:00 PM',
        price: 'EGP 450',
        status: BookingStatus.declined,
        avatar: 'https://i.pravatar.cc/150?img=5',
      ),
      BookingRequest(
        id: '6',
        name: 'Ahmed Samir',
        sport: 'Basketball',
        duration: '1 Hour',
        dateTime: 'Sat, 07:00 PM',
        price: 'EGP 300',
        status: BookingStatus.approved,
        avatar: 'https://i.pravatar.cc/150?img=6',
      ),
    ];
  }

  Future<void> acceptBooking(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
  }

  Future<void> declineBooking(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
  }
}
