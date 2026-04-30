import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/ownerDashboard/data/owner_dashboard_repository.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/cubit/owner_dashboard_state.dart';

class OwnerDashboardCubit extends Cubit<OwnerDashboardState> {
  final OwnerDashboardRepository _repository;

  OwnerDashboardCubit(this._repository) : super(OwnerDashboardInitial());

  Future<void> loadDashboard() async {
    emit(OwnerDashboardLoading());
    try {
      final data = await _repository.fetchDashboardData();
      emit(OwnerDashboardLoaded(data));
    } catch (e) {
      emit(OwnerDashboardError("Failed to load dashboard. Please try again."));
    }
  }
}
