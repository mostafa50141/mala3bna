import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/otp_verification_body.dart';
import 'package:mala3bna/features/auth/presentation/views_model/cubit/reset_password_cubit.dart';

class OTPVerificationScreen extends StatelessWidget {
  final ResetPasswordCubit cubit;

  const OTPVerificationScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: const Scaffold(body: OTPVerificationBody()),
    );
  }
}
