enum BookingStatus { pending, approved }

class BookingRequest {
  final String name;
  final String sport;
  final String duration;
  final String dateTime;
  final BookingStatus status;
  final String avatar;

  const BookingRequest({
    required this.name,
    required this.sport,
    required this.duration,
    required this.dateTime,
    required this.status,
    required this.avatar,
  });
}
