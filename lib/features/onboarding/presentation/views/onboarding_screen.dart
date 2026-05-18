import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_page_view.dart';
import 'package:mala3bna/features/onboarding/presentation/views_model/cubit/onboarding_cubit.dart';
import 'package:mala3bna/features/welcome_screen/presentation/views/welcome_screen.dart';

/// Entry-point for the onboarding flow.
///
/// Wraps the [OnboardingPageView] with [BlocProvider] so the cubit
/// lifecycle is tied to this screen. Listens for [OnboardingCompleted]
/// to trigger the navigation to the next screen.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Make sure the status bar stays transparent.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleted) {
            // Navigate away when onboarding is done.
            Get.offAll(
              () => const WelcomeScreen(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 500),
            );
          }
        },
        // Using PopScope to prevent back button from returning to Splash.
        child: PopScope(
          canPop: false,
          child: const Scaffold(
            backgroundColor: Colors.black, // fallback behind gradient
            body: OnboardingPageView(),
          ),
        ),
      ),
    );
  }
}
