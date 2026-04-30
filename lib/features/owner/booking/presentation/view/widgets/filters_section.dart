import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/booking/presentation/cubit/booking_cubit.dart';
import 'package:mala3bna/features/owner/booking/presentation/cubit/booking_state.dart';

class FiltersSection extends StatelessWidget {
  const FiltersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        if (state is! BookingLoaded) return const SizedBox.shrink();

        final cubit = context.read<BookingCubit>();
        final active = state.activeFilter;

        return SizedBox(
          height: 42,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _FilterChip(
                label: 'All',
                icon: Icons.grid_view_rounded,
                isActive: active == BookingFilter.all,
                onTap: () => cubit.setFilter(BookingFilter.all),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Pending',
                icon: Icons.pending_actions_rounded,
                isActive: active == BookingFilter.pending,
                onTap: () => cubit.setFilter(BookingFilter.pending),
                badgeColor: Colors.orange,
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Approved',
                icon: Icons.check_circle_outline_rounded,
                isActive: active == BookingFilter.approved,
                onTap: () => cubit.setFilter(BookingFilter.approved),
                badgeColor: AppColors.primaryColor,
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: 'Declined',
                icon: Icons.cancel_outlined,
                isActive: active == BookingFilter.declined,
                onTap: () => cubit.setFilter(BookingFilter.declined),
                badgeColor: Colors.redAccent,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final Color? badgeColor;

  const _FilterChip({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = badgeColor ?? AppColors.primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        decoration: BoxDecoration(
          color: isActive
              ? activeColor.withOpacity(0.15)
              : const Color(0xFF1C1F26),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isActive ? activeColor : Colors.white.withOpacity(0.08),
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 15,
              color: isActive ? activeColor : Colors.white54,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? activeColor : Colors.white54,
                fontSize: 13,
                fontWeight:
                    isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
