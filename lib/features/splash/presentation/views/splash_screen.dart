import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/splash/presentation/views/widgets/splash_screen_body.dart';
import 'package:mala3bna/features/splash/presentation/views_model/cubit/splash_cubit.dart';

/// Entry-point widget for the splash feature.
///
/// Provides [SplashCubit] to the subtree so that [SplashScreenBody] can
/// access it via [context.read] / [BlocListener] without coupling the
/// cubit creation to the widget that consumes it.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit(),
      child: const SplashScreenBody(),
    );
  }
}
