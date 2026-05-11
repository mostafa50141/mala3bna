import '../models/court_model.dart';
import '../models/court_image_model.dart';
import '../models/update_court_request.dart';
import '../../domain/repositories/court_repository.dart';
import '../datasources/court_remote_data_source.dart';

class CourtRepositoryImpl implements CourtRepository {
  final CourtRemoteDataSource remoteDataSource;

  CourtRepositoryImpl({required this.remoteDataSource});

  @override
  Future<CourtModel> getCourtDetails(String id) {
    return remoteDataSource.getCourtDetails(id);
  }

  @override
  Future<CourtImageModel> uploadCourtImage(String courtId, String filePath) {
    return remoteDataSource.uploadCourtImage(courtId, filePath);
  }

  @override
  Future<void> removeCourtImage(String courtId, String imageId) {
    return remoteDataSource.removeCourtImage(courtId, imageId);
  }

  @override
  Future<void> updateCourt(UpdateCourtRequest request) {
    return remoteDataSource.updateCourt(request);
  }
}
