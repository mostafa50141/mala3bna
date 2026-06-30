import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/ownerDashboard/domain/repositories/dashboard_repository.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/cubit/owner_dashboard_state.dart';

class OwnerDashboardCubit extends Cubit<OwnerDashboardState> {
  final DashboardRepository _repository;

  OwnerDashboardCubit(this._repository) : super(OwnerDashboardInitial());

  Future<void> loadDashboard() async {
    emit(OwnerDashboardLoading());
    final result = await _repository.fetchDashboard();
    
    result.fold(
      (failure) => emit(OwnerDashboardError(failure.errmessage ?? "Failed to load dashboard. Please try again.")),
      (data) => emit(OwnerDashboardLoaded(data)),
    );
  }
}
