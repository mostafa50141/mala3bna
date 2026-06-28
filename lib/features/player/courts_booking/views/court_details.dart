import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/player/courts_booking/data/repos/review_repo.dart';
import 'package:mala3bna/features/player/courts_booking/presentation/cubit/review_cubit.dart';
import 'package:mala3bna/features/player/courts_booking/views/widgets/court_details_body.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';

class BookingsView extends StatelessWidget {
  final CourtModel courtModel;
  const BookingsView({super.key, required this.courtModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReviewCubit>(
      create: (context) => ReviewCubit(getIt.get<ReviewRepo>())
        ..getReviews(fieldId: courtModel.id),
      child: CourtDetailsBody(court: courtModel),
    );
  }
}
