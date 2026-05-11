import '../../data/models/court_model.dart';
import '../../data/models/court_image_model.dart';
import '../../data/models/update_court_request.dart';

abstract class CourtRepository {
  Future<CourtModel> getCourtDetails(String id);

  Future<CourtImageModel> uploadCourtImage(String courtId, String filePath);

  Future<void> removeCourtImage(String courtId, String imageId);

  Future<void> updateCourt(UpdateCourtRequest request);
}
