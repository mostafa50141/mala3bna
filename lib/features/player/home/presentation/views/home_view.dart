import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/home_view_body.dart';
import 'package:mala3bna/features/player/home/presentation/view_model/courts_cubit/courts_cubit.dart';
import 'package:mala3bna/features/player/home/data/repos/courts_repo.dart';
import 'package:mala3bna/core/utils/service_locator.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CourtsCubit>(
      create: (context) => CourtsCubit(getIt.get<CourtsRepo>())..getCourts(),
      child: const HomeViewBody(),
    );
  }
}
