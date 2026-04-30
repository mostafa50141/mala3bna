enum BookingStatus { pending, approved, declined }

class BookingRequest {
  final String id;
  final String name;
  final String sport;
  final String duration;
  final String dateTime;
  final String price;
  final String avatar;
  BookingStatus status;

  BookingRequest({
    required this.id,
    required this.name,
    required this.sport,
    required this.duration,
    required this.dateTime,
    required this.price,
    required this.status,
    required this.avatar,
  });

  BookingRequest copyWith({BookingStatus? status}) {
    return BookingRequest(
      id: id,
      name: name,
      sport: sport,
      duration: duration,
      dateTime: dateTime,
      price: price,
      avatar: avatar,
      status: status ?? this.status,
    );
  }
}
