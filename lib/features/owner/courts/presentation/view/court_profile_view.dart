import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/owner/courts/data/repo/court_profile_repository.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_cubit.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/my_court_body.dart';

class CourtProfileView extends StatelessWidget {
  const CourtProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CourtProfileCubit(CourtProfileRepository())..loadCourtProfile(),
      child: const Scaffold(body: CourtProfileBody()),
    );
  }
}
