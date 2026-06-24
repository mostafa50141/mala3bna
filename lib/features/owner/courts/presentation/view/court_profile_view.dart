import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_cubit.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/my_court_body.dart';

class CourtProfileView extends StatelessWidget {
  final String? fieldId;
  const CourtProfileView({super.key, this.fieldId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CourtProfileCubit(getIt<CourtRepository>())..loadCourtProfile(fieldId),
      child: const Scaffold(body: CourtProfileBody()),
    );
  }
}
