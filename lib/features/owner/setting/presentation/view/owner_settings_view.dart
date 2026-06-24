import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/owner/setting/domain/repositories/setting_repository.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_cubit.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/owner_setting_body.dart';

class OwnerSettingsView extends StatelessWidget {
  const OwnerSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OwnerProfileCubit(getIt<SettingRepository>())..loadProfile(),
      child: const Scaffold(body: OwnerSettingsBody()),
    );
  }
}
