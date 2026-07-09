import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/auth/presentation/views/login_screen.dart';
import 'package:mala3bna/features/auth/presentation/views/sign_up_screen.dart';
import 'package:mala3bna/features/player/home/presentation/views/home_view.dart';

class WelcomeScreenBody extends StatefulWidget {
  const WelcomeScreenBody({super.key});

  @override
  State<WelcomeScreenBody> createState() => _WelcomeScreenBodyState();
}

class _WelcomeScreenBodyState extends State<WelcomeScreenBody>
    with TickerProviderStateMixin {
  // â”€â”€ Animation controllers â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  late AnimationController _masterController;
  late AnimationController _logoGlowController;
  late AnimationController _floatController;

  // â”€â”€ Animations â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _logoGlow;
  late Animation<double> _logoFloat;

  late Animation<Offset> _titleSlide;
  late Animation<double> _titleFade;

  late Animation<Offset> _subtitleSlide;
  late Animation<double> _subtitleFade;

  late Animation<Offset> _btnSlide;
  late Animation<double> _btnFade;

  // â”€â”€ Lifecycle â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  @override
  void initState() {
    super.initState();

    _masterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _logoGlowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _setupAnimations();
    _masterController.forward();
  }

  void _setupAnimations() {
    // Logo â€” elastic pop + fade
    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.0, 0.40, curve: Curves.elasticOut),
      ),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.0, 0.25, curve: Curves.easeOut),
      ),
    );

    // Logo glow pulse
    _logoGlow = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _logoGlowController, curve: Curves.easeInOut),
    );

    // Logo float (subtle up/down)
    _logoFloat = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Title â€” slide up + fade
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.30, 0.65, curve: Curves.easeOutCubic),
    ));
    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.30, 0.58, curve: Curves.easeOut),
    ));

    // Subtitle
    _subtitleSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.45, 0.78, curve: Curves.easeOutCubic),
    ));
    _subtitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.45, 0.72, curve: Curves.easeOut),
    ));

    // Buttons
    _btnSlide = Tween<Offset>(
      begin: const Offset(0, 0.6),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.60, 1.0, curve: Curves.easeOutCubic),
    ));
    _btnFade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.60, 0.95, curve: Curves.easeOut),
    ));
  }

  @override
  void dispose() {
    _masterController.dispose();
    _logoGlowController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  // â”€â”€ Build â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // â”€â”€ Lottie background â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          SizedBox.expand(
            child: Lottie.asset(
              'assets/animations/Football team players.json',
              fit: BoxFit.cover,
              repeat: true,
            ),
          ),

          // â”€â”€ Multi-layer gradient overlay â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x99000000), // top dark
                  Color(0x33000000), // middle subtle
                  Color(0xCC000000), // bottom strong
                ],
                stops: [0.0, 0.4, 1.0],
              ),
            ),
          ),

          // â”€â”€ Green accent glow at bottom â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Positioned(
            bottom: -80,
            left: -60,
            child: AnimatedBuilder(
              animation: _logoGlow,
              builder: (context, _) => Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withValues(
                        alpha: 0.12 + (_logoGlow.value * 0.10),
                      ),
                      blurRadius: 120,
                      spreadRadius: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // â”€â”€ Main content â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.07),

                // â”€â”€ Animated Logo â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                FadeTransition(
                  opacity: _logoOpacity,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: AnimatedBuilder(
                      animation: Listenable.merge(
                          [_logoGlow, _floatController]),
                      builder: (context, _) {
                        return Transform.translate(
                          offset: Offset(0, _logoFloat.value),
                          child: Center(
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryColor.withValues(
                                      alpha: 0.25 + (_logoGlow.value * 0.40),
                                    ),
                                    blurRadius: 24 + (_logoGlow.value * 24),
                                    spreadRadius: 4 + (_logoGlow.value * 6),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: AppColors.primaryColor
                                    .withValues(alpha: 0.15),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/app_icon.png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // â”€â”€ Title â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                FadeTransition(
                  opacity: _titleFade,
                  child: SlideTransition(
                    position: _titleSlide,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) =>
                                const LinearGradient(
                              colors: [Colors.white, Color(0xFF2E9F81)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds),
                            child: Text(
                              'Your Court Awaits',
                              style: Style.textStyle30Bold.copyWith(
                                color: Colors.white,
                                fontSize: 34,
                                letterSpacing: 0.5,
                                height: 1.1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // â”€â”€ Subtitle â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                FadeTransition(
                  opacity: _subtitleFade,
                  child: SlideTransition(
                    position: _subtitleSlide,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Book courts, find players, and connect\nwith coaches across Egypt.',
                        style: Style.textStyle16.copyWith(
                          color: Colors.white.withValues(alpha: 0.75),
                          height: 1.6,
                          letterSpacing: 0.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.07),

                // â”€â”€ Buttons â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                FadeTransition(
                  opacity: _btnFade,
                  child: SlideTransition(
                    position: _btnSlide,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Column(
                        children: [
                          // Log In â€” gradient button
                          _GradientButton(
                            label: 'Log In',
                            onTap: () => Get.to(const LoginScreen()),
                          ),

                          const SizedBox(height: 14),

                          // Sign Up â€” glassmorphism outlined button
                          _OutlinedGlassButton(
                            label: 'Sign Up',
                            onTap: () => Get.to(const SignUpScreen()),
                          ),

                          const SizedBox(height: 20),

                          // Guest
                          GestureDetector(
                            onTap: () => Get.to(const HomeView()),
                            child: Text(
                              'Continue as Guest',
                              style: Style.textStyle14.copyWith(
                                color: Colors.white.withValues(alpha: 0.55),
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    Colors.white.withValues(alpha: 0.35),
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.06),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// â”€â”€ Gradient Login Button â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _GradientButton extends StatefulWidget {
  const _GradientButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 110),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) async {
        await _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Color(0xFF2E9F81), Color(0xFF1A7A60)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withValues(alpha: 0.40),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.label,
              style: Style.textStyle18Bold.copyWith(
                color: Colors.white,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// â”€â”€ Glassmorphism Outlined Button â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _OutlinedGlassButton extends StatefulWidget {
  const _OutlinedGlassButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  State<_OutlinedGlassButton> createState() => _OutlinedGlassButtonState();
}

class _OutlinedGlassButtonState extends State<_OutlinedGlassButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 110),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) async {
        await _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withValues(alpha: 0.08),
            border: Border.all(
              color: AppColors.primaryColor.withValues(alpha: 0.70),
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: Style.textStyle18Bold.copyWith(
                color: AppColors.primaryColor,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

