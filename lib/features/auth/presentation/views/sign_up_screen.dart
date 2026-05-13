import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/auth/data/Repos/auth_repo.dart';
import 'package:mala3bna/features/auth/presentation/views/widgets/sign_up_body.dart';
import 'package:mala3bna/features/auth/presentation/views_model/cubit/auth_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocProvider(
      child: const SignUpBody(),
      create: (context) => AuthCubit(getIt.get<AuthRepo>()),
    );
  }
}
