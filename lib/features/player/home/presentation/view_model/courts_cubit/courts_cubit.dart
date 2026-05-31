import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';
import 'package:mala3bna/features/player/home/data/repos/courts_repo.dart';
import 'package:latlong2/latlong.dart';

part 'courts_state.dart';

class CourtsCubit extends Cubit<CourtsState> {
  final CourtsRepo courtsRepo;

  List<CourtModel> allCourts = [];
  List<CourtModel> filteredCourts = [];
  String selectedSport = 'All';
  String searchQuery = '';

  CourtsCubit(this.courtsRepo) : super(CourtsInitial());

  Future<void> getCourts() async {
    emit(CourtsLoading());
    var result = await courtsRepo.getCourts();
    result.fold(
      (failure) =>
          emit(CourtsFailure(failure.errmessage ?? "Something went wrong")),
      (courts) {
        allCourts = courts;
        filteredCourts = courts;
        emit(CourtsSuccess(courts: courts));
      },
    );
  }

  void filterBySport(String sport) {
    selectedSport = sport;
    _applyFilters();
  }

  void search(String query) {
    searchQuery = query;
    _applyFilters();
  }

  void sortByDistance(double userLat, double userLng) {
    final Distance distance = const Distance();
    allCourts.sort((a, b) {
      final distA = distance(LatLng(userLat, userLng), LatLng(a.lat, a.lng));
      final distB = distance(LatLng(userLat, userLng), LatLng(b.lat, b.lng));
      return distA.compareTo(distB);
    });
    _applyFilters();
  }

  void _applyFilters() {
    var result = allCourts;
    if (selectedSport != 'All') {
      result = result.where((c) => c.sport == selectedSport).toList();
    }
    if (searchQuery.isNotEmpty) {
      result = result
          .where(
            (c) => c.name.toLowerCase().contains(searchQuery.toLowerCase()),
          )
          .toList();
    }
    filteredCourts = result;
    emit(CourtsSuccess(courts: filteredCourts));
  }
}
