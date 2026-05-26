part of 'courts_cubit.dart';

@immutable
sealed class CourtsState {}

final class CourtsInitial extends CourtsState {}

final class CourtsLoading extends CourtsState {}

final class CourtsSuccess extends CourtsState {
  final List<CourtModel> courts;
  CourtsSuccess({required this.courts});
}

final class CourtsFailure extends CourtsState {
  final String errorMessage;
  CourtsFailure(this.errorMessage);
}
