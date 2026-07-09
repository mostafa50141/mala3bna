import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/onboarding/presentation/views_model/cubit/onboarding_cubit.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_constants.dart';

/// Primary CTA button.
///
/// Switches between \"Ø§Ù„ØªØ§Ù„ÙŠ\" (Next) and \"Ø§Ø¨Ø¯Ø£ Ø§Ù„Ø¢Ù†\" (Get Started) using
/// [AnimatedSwitcher] for a smooth crossfade. Accepts [accentColor] to
/// match the current onboarding page's color theme.
class OnboardingNextButton extends StatefulWidget {
  final bool isLastPage;
  final Color accentColor;

  const OnboardingNextButton({
    super.key,
    required this.isLastPage,
    this.accentColor = AppColors.primaryColor,
  });

  @override
  State<OnboardingNextButton> createState() => _OnboardingNextButtonState();
}

class _OnboardingNextButtonState extends State<OnboardingNextButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressCtrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 110),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _pressCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressCtrl.forward(),
      onTapUp: (_) async {
        await _pressCtrl.reverse();
        if (context.mounted) context.read<OnboardingCubit>().nextPage();
      },
      onTapCancel: () => _pressCtrl.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: SizedBox(
          height: OnboardingConstants.nextButtonHeight,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.accentColor,
                  widget.accentColor.withValues(alpha: 0.72),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(
                OnboardingConstants.nextButtonRadius,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.accentColor.withValues(alpha: 0.38),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: OnboardingConstants.buttonAnimDuration,
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: Text(
                  widget.isLastPage ? 'ابدا الان' : 'التالي',
                  key: ValueKey<bool>(widget.isLastPage),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
