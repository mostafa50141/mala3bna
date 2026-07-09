import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/role/user_role.dart';
import 'package:mala3bna/core/widgets/custom_animateds_snack_bar.dart';
import 'package:mala3bna/core/widgets/custom_circular_loading.dart';
import 'package:mala3bna/core/navigation/player_main_navigation.dart';
import 'package:mala3bna/core/navigation/owner_main_navigation.dart';
import 'package:mala3bna/features/auth/presentation/data/auth_controller.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/login_animated_logo.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/login_welcome_title.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/login_email_field.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/login_password_section.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/login_button.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/login_signup_footer.dart';
import 'package:mala3bna/features/auth/presentation/views_model/cubit/auth_cubit.dart';

// â”€â”€ Helper â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
UserRole _mapUserTypeToRole(String? userType) {
  switch (userType) {
    case 'owner':
      return UserRole.owner;
    case 'coach':
      return UserRole.coach;
    default:
      return UserRole.player;
  }
}

// â”€â”€ Widget â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody>
    with TickerProviderStateMixin {
  // â”€â”€ Form â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _authController = Get.find<AuthController>();

  // â”€â”€ Animation controllers â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  late AnimationController _masterController;
  late AnimationController _logoController;
  late AnimationController _bgController;

  // â”€â”€ Animations â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _logoGlow;
  late Animation<Offset> _titleSlide;
  late Animation<double> _titleFade;
  late Animation<Offset> _emailSlide;
  late Animation<double> _emailFade;
  late Animation<Offset> _passwordSlide;
  late Animation<double> _passwordFade;
  late Animation<Offset> _btnSlide;
  late Animation<double> _btnFade;
  late Animation<Offset> _signupSlide;
  late Animation<double> _signupFade;
  late Animation<double> _bgAnimation;

  // â”€â”€ Lifecycle â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _initControllers();
    _setupAnimations();
    _masterController.forward();
  }

  void _initControllers() {
    _masterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  void _setupAnimations() {
    // Logo
    _logoScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.0, 0.35, curve: Curves.elasticOut),
      ),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.0, 0.25, curve: Curves.easeOut),
      ),
    );
    _logoGlow = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    // Title
    _titleSlide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.18, 0.50, curve: Curves.easeOutCubic),
    ));
    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.18, 0.45, curve: Curves.easeOut),
    ));

    // Email
    _emailSlide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.33, 0.65, curve: Curves.easeOutCubic),
    ));
    _emailFade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.33, 0.60, curve: Curves.easeOut),
    ));

    // Password
    _passwordSlide =
        Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
            .animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.45, 0.78, curve: Curves.easeOutCubic),
    ));
    _passwordFade = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.45, 0.73, curve: Curves.easeOut),
    ));

    // Button
    _btnSlide = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.58, 0.88, curve: Curves.easeOutCubic),
    ));
    _btnFade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.58, 0.85, curve: Curves.easeOut),
    ));

    // Sign up footer
    _signupSlide =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
            .animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.72, 1.0, curve: Curves.easeOutCubic),
    ));
    _signupFade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.72, 1.0, curve: Curves.easeOut),
    ));

    // Background
    _bgAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bgController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _masterController.dispose();
    _logoController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  // â”€â”€ Helpers â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  void _onLoginPressed() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().login(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
  }

  void _handleAuthSuccess(AuthSuccess state) {
    _authController.setRole(_mapUserTypeToRole(state.user.userType));
    switch (state.user.userType) {
      case 'owner':
        Get.offAll(() => const OwnerMainNavigation());
        break;
      case 'coach':
      case 'player':
      default:
        Get.offAll(() => const PlayerMainNavigation());
        break;
    }
  }

  // â”€â”€ Build â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: AnimatedBuilder(
        animation: _bgAnimation,
        builder: (context, child) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(
                    const Color(0xFF0A1A1C), const Color(0xFF0D2820), _bgAnimation.value)!,
                Color.lerp(
                    const Color(0xFF0F2D31), const Color(0xFF0A2015), _bgAnimation.value)!,
                Color.lerp(
                    const Color(0xFF1A1D24), const Color(0xFF112515), _bgAnimation.value)!,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: child,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.06),

                    // Logo
                    LoginAnimatedLogo(
                      scaleAnimation: _logoScale,
                      opacityAnimation: _logoOpacity,
                      glowAnimation: _logoGlow,
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    // Title
                    LoginWelcomeTitle(
                      fadeAnimation: _titleFade,
                      slideAnimation: _titleSlide,
                    ),

                    SizedBox(height: screenHeight * 0.055),

                    // Email field
                    LoginEmailField(
                      controller: _emailController,
                      fadeAnimation: _emailFade,
                      slideAnimation: _emailSlide,
                    ),

                    const Gap(20),

                    // Password field + Forgot Password
                    LoginPasswordSection(
                      controller: _passwordController,
                      fadeAnimation: _passwordFade,
                      slideAnimation: _passwordSlide,
                    ),

                    SizedBox(height: screenHeight * 0.04),

                    // Login button (with BLoC)
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) _handleAuthSuccess(state);
                        if (state is AuthFailure) {
                          showAnimatedSnackDialog(
                            context,
                            message: state.errorMessage,
                            type: AnimatedSnackBarType.error,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return FadeTransition(
                            opacity: _btnFade,
                            child: const Center(
                                child: CustomeCircularLaoding()),
                          );
                        }
                        return LoginButton(
                          onTap: _onLoginPressed,
                          fadeAnimation: _btnFade,
                          slideAnimation: _btnSlide,
                        );
                      },
                    ),

                    const Gap(32),

                    // OR + Sign Up
                    LoginSignupFooter(
                      fadeAnimation: _signupFade,
                      slideAnimation: _signupSlide,
                    ),

                    const Gap(24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

