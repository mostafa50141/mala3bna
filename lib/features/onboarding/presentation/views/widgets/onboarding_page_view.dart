import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/onboarding/presentation/views_model/cubit/onboarding_cubit.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_constants.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_illustration.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_next_button.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_page_content.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_page_indicator.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_skip_button.dart';

/// The core visual layout of the onboarding flow.
///
/// Handles:
/// 1. The background animated gradient that color-shifts per page.
/// 2. The physical [PageView] that scrolls through the illustrations.
/// 3. The staggered animations for the text content when pages change.
/// 4. The bottom layout with indicator and next button.
class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView>
    with TickerProviderStateMixin {
  late AnimationController _contentAnimController;
  late Animation<double> _titleOpacity;
  late Animation<Offset> _titleSlide;
  late Animation<double> _descOpacity;
  late Animation<Offset> _descSlide;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    // Play the content animation for the first page.
    _contentAnimController.forward();
  }

  void _initAnimations() {
    _contentAnimController = AnimationController(
      vsync: this,
      duration:
          OnboardingConstants.contentAnimDuration +
          OnboardingConstants.contentAnimDelay,
    );

    // Title animates immediately over the first 350ms
    _titleSlide = Tween<Offset>(begin: const Offset(0.0, 0.4), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _contentAnimController,
            curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
          ),
        );

    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentAnimController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    // Description animates with a slight delay
    _descSlide = Tween<Offset>(begin: const Offset(0.0, 0.6), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _contentAnimController,
            curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
          ),
        );

    _descOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contentAnimController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _contentAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingPageChanged) {
          // Re-trigger the text animation whenever the page changes.
          _contentAnimController.forward(from: 0.0);
        }
      },
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();
        final currentPage = cubit.currentPage;
        final isLastPage = cubit.isLastPage;

        return TweenAnimationBuilder<Color?>(
          duration: OnboardingConstants.bgGradientDuration,
          tween: ColorTween(end: OnboardingConstants.bgTopColors[currentPage]),
          builder: (context, topColor, _) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    topColor ?? AppColors.backgroundColor,
                    AppColors.backgroundColor,
                  ],
                  stops: const [0.0, 0.5],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // ── Skip Button ──────────────────────────────────────────
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, right: 16),
                        child: OnboardingSkipButton(isLastPage: isLastPage),
                      ),
                    ),

                    // ── Scrollable Illustrations ─────────────────────────────
                    Expanded(
                      flex: OnboardingConstants.illustrationAreaFlex.toInt(),
                      child: PageView.builder(
                        controller: cubit.pageController,
                        onPageChanged: cubit.onPageChanged,
                        physics: const BouncingScrollPhysics(),
                        itemCount: OnboardingConstants.pageCount,
                        itemBuilder: (context, index) {
                          return Center(
                            child: OnboardingIllustration(
                              page: OnboardingConstants.pages[index],
                              pageIndex: index,
                            ),
                          );
                        },
                      ),
                    ),

                    // ── Text Content & Bottom Controls ───────────────────────
                    Expanded(
                      flex: OnboardingConstants.contentAreaFlex.toInt(),
                      child: Column(
                        children: [
                          OnboardingPageContent(
                            page: OnboardingConstants.pages[currentPage],
                            titleOpacity: _titleOpacity,
                            titleSlide: _titleSlide,
                            descOpacity: _descOpacity,
                            descSlide: _descSlide,
                          ),

                          const Spacer(),

                          OnboardingPageIndicator(
                            currentPage: currentPage,
                            pageCount: OnboardingConstants.pageCount,
                          ),

                          const SizedBox(
                            height:
                                OnboardingConstants.spacingIndicatorToButton,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal:
                                  OnboardingConstants.contentHorizontalPadding,
                            ),
                            child: OnboardingNextButton(isLastPage: isLastPage),
                          ),

                          const SizedBox(
                            height: OnboardingConstants.bottomSafeAreaPadding,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
