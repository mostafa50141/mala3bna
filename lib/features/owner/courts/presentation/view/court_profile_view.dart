import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_cubit.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/my_court_body.dart';

class CourtProfileView extends StatelessWidget {
  final String? fieldId;
  /// When true, the cubit is provided by the parent (OwnerMainNavigation)
  /// via BlocProvider.value — we must NOT create a new one here.
  final bool fromNavigation;
  const CourtProfileView({super.key, this.fieldId, this.fromNavigation = false});

  @override
  Widget build(BuildContext context) {
    if (fromNavigation) {
      // Cubit is already in the widget tree from OwnerMainNavigation
      return const Scaffold(body: CourtProfileBody());
    }
    return BlocProvider(
      create: (_) =>
          CourtProfileCubit(getIt<CourtRepository>())..loadCourtProfile(fieldId),
      child: const Scaffold(body: CourtProfileBody()),
    );
  }
}
