import 'package:dartz/dartz.dart';
import 'package:mala3bna/core/errors/failure.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';

abstract class CourtsRepo {
  Future<Either<Failure, List<CourtModel>>> getCourts();
  Future<Either<Failure, CourtModel>> getCourtById({required int id});
}
