import '../../data/models/update_court_request.dart';
import '../repositories/court_repository.dart';

class UpdateCourtUseCase {
  final CourtRepository repository;

  UpdateCourtUseCase(this.repository);

  Future<void> call(UpdateCourtRequest request) async {
    return repository.updateCourt(request);
  }
}
