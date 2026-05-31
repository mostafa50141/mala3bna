import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/player/home/data/repos/courts_repo.dart';
import 'package:mala3bna/features/player/home/presentation/view_model/courts_cubit/courts_cubit.dart';
import 'package:mala3bna/features/player/map/views/widgets/map_body.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourtsCubit(getIt.get<CourtsRepo>())..getCourts(),
      child: const MapBody(),
    );
  }
}
