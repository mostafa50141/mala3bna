import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/create_new_password_body.dart';
import 'package:mala3bna/features/auth/presentation/views_model/cubit/reset_password_cubit.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  final ResetPasswordCubit cubit;

  const CreateNewPasswordScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: const Scaffold(body: CreateNewPasswordBody()),
    );
  }
}
