import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/booking/domain/entities/booking_entity.dart';
import 'package:mala3bna/features/owner/booking/presentation/cubit/booking_cubit.dart';
import 'package:mala3bna/features/owner/booking/presentation/cubit/booking_state.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_cubit.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/court_profile_state.dart';
import 'package:mala3bna/features/owner/courts/domain/entities/court_entity.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/action_buttons.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/amenities_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/header_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/pricing_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/rating_section.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/reviews_list.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/tabs_section.dart';

class CourtProfileBody extends StatefulWidget {
  const CourtProfileBody({super.key});

  @override
  State<CourtProfileBody> createState() => _CourtProfileBodyState();
}

class _CourtProfileBodyState extends State<CourtProfileBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<CourtProfileCubit, CourtProfileState>(
        builder: (context, state) {
          if (state is CourtProfileLoading) {
            return const _CourtProfileSkeleton();
          }

          if (state is CourtProfileError) {
            return _ErrorState(
              message: state.message,
              onRetry: () =>
                  context.read<CourtProfileCubit>().loadCourtProfile(),
            );
          }

          if (state is CourtProfileLoaded) {
            _fadeCtrl.forward();
            final vm = state.courtProfile;

            return FadeTransition(
              opacity: _fadeAnim,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: HeaderSection(vm: vm)),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        if (!vm.isActive)
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withValues(alpha: 0.1),
                              border: Border.all(
                                color: Colors.redAccent.withValues(alpha: 0.3),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.redAccent,
                                  size: 28,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Court Closed for Maintenance'.tr,
                                        style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      if (vm
                                              .maintenanceDescription
                                              ?.isNotEmpty ==
                                          true)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4,
                                          ),
                                          child: Text(
                                            vm.maintenanceDescription!,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13,
                                            ),
                                          ),
                                        )
                                      else if (vm.maintenanceType?.isNotEmpty ==
                                              true &&
                                          vm.maintenanceType != 'other')
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4,
                                          ),
                                          child: Text(
                                            'Reason: '.tr +
                                                (vm.maintenanceType ?? '').tr,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ActionButtons(courtId: vm.id),
                        const SizedBox(height: 20),
                        TabsSection(
                          onTabChanged: (i) => setState(() => _selectedTab = i),
                        ),
                        const SizedBox(height: 20),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          switchInCurve: Curves.easeIn,
                          switchOutCurve: Curves.easeOut,
                          transitionBuilder: (child, anim) =>
                              FadeTransition(opacity: anim, child: child),
                          child: _selectedTab == 0
                              ? _DetailsTab(key: const ValueKey(0), vm: vm)
                              : const _BookingsTab(key: ValueKey(1)),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ─── Details Tab ───────────────────────────────────────────────────────────────
class _DetailsTab extends StatelessWidget {
  final CourtEntity vm;

  const _DetailsTab({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (vm.sportType != null && vm.sportType!.isNotEmpty) ...[
          _buildSportTypeBanner(),
          const SizedBox(height: 16),
        ],
        const PricingSection(),
        const SizedBox(height: 16),
        AmenitiesSectionCourtProfile(vm: vm),
        const SizedBox(height: 16),
        RatingsSection(vm: vm),
        const SizedBox(height: 16),
        ReviewsList(fieldId: int.tryParse(vm.id) ?? 0),
      ],
    );
  }

  Widget _buildSportTypeBanner() {
    IconData icon;
    String labelKey;
    switch (vm.sportType) {
      case 'padel':
        icon = Icons.sports_tennis;
        labelKey = 'Padel';
        break;
      case 'tennis':
        icon = Icons.sports_tennis_rounded;
        labelKey = 'Tennis';
        break;
      case 'football':
      default:
        icon = Icons.sports_soccer;
        labelKey = 'Football';
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor.withValues(alpha: 0.15),
            AppColors.primaryColor.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sport Type'.tr,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  labelKey.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.verified, color: AppColors.primaryColor, size: 24),
        ],
      ),
    );
  }
}

// ─── Bookings Tab — Weekly Schedule ───────────────────────────────────────────
class _BookingsTab extends StatelessWidget {
  const _BookingsTab({super.key});

  // Hours shown in the grid (6 AM → 12 AM)
  static const int _startHour = 6;
  static const int _endHour = 24;

  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    // Get current court id from CourtProfileCubit
    final courtState = context.watch<CourtProfileCubit>().state;
    final String? courtId = courtState is CourtProfileLoaded
        ? courtState.courtProfile.id
        : courtState is CourtProfileToggling
        ? courtState.courtProfile.id
        : null;

    // Get bookings from BookingCubit (provided by OwnerMainNavigation)
    final bookingState = context.watch<BookingCubit>().state;

    if (bookingState is BookingLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        ),
      );
    }

    if (bookingState is! BookingLoaded) {
      return _emptySchedule(context);
    }

    // Filter to this court only, with approved status
    final List<BookingEntity> courtBookings = bookingState.allBookings
        .where(
          (b) =>
              (courtId == null || b.fieldId == courtId) &&
              b.status != BookingStatus.declined,
        )
        .toList();

    // Build a lookup: weekdayIndex (0=Mon) → hour → list of bookings
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    // Map: day index (0-6) -> hour (int) -> bookings
    final Map<int, Map<int, List<BookingEntity>>> grid = {
      for (int i = 0; i < 7; i++) i: {},
    };

    for (final b in courtBookings) {
      final parsed = DateTime.tryParse(b.dateTime);
      if (parsed == null) continue;
      final dayIdx = parsed.weekday - 1; // 0=Mon
      // Only show current week
      final weekEnd = weekStart.add(const Duration(days: 7));
      if (parsed.isBefore(weekStart) || parsed.isAfter(weekEnd)) continue;
      final hour = parsed.hour;
      grid[dayIdx]!.putIfAbsent(hour, () => []).add(b);
    }

    final bool hasAnyBooking = grid.values.any((dayMap) => dayMap.isNotEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Week header ──────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_view_week_rounded,
                size: 16,
                color: Colors.grey,
              ),
              const SizedBox(width: 6),
              Text(
                '${'Week of'.tr} ${_formatDate(weekStart)} – ${_formatDate(weekStart.add(const Duration(days: 6)))}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),

        if (!hasAnyBooking) _emptySchedule(context),
        if (hasAnyBooking) _buildGrid(context, grid),

        const SizedBox(height: 16),
        // ── Legend ───────────────────────────────────────────────────
        Row(
          children: [
            _LegendDot(color: AppColors.primaryColor, label: 'Approved'.tr),
            const SizedBox(width: 16),
            _LegendDot(color: Colors.orange, label: 'Pending'.tr),
          ],
        ),
      ],
    );
  }

  Widget _buildGrid(
    BuildContext context,
    Map<int, Map<int, List<BookingEntity>>> grid,
  ) {
    const double hourRowHeight = 52;
    const double hourLabelWidth = 44;
    const double dayColWidth = 48;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              Theme.of(
                context,
              ).textTheme.bodyMedium?.color?.withOpacity(0.06) ??
              Colors.white.withOpacity(0.06),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Day header row ─────────────────────────────────────
            Row(
              children: [
                SizedBox(width: hourLabelWidth), // spacer above hour labels
                ...List.generate(7, (d) {
                  return SizedBox(
                    width: dayColWidth,
                    child: Center(
                      child: Text(
                        _days[d].tr,
                        style: TextStyle(
                          color: d == DateTime.now().weekday - 1
                              ? AppColors.primaryColor
                              : Colors.grey,
                          fontSize: 11,
                          fontWeight: d == DateTime.now().weekday - 1
                              ? FontWeight.bold
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
            const Divider(color: Colors.white10, height: 1),
            // ── Hour rows ──────────────────────────────────────────
            ...List.generate(_endHour - _startHour, (i) {
              final hour = _startHour + i;
              return Column(
                children: [
                  SizedBox(
                    height: hourRowHeight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Hour label
                        SizedBox(
                          width: hourLabelWidth,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              _formatHour(hour),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        // Day cells
                        ...List.generate(7, (d) {
                          final bookingsHere = grid[d]?[hour] ?? [];
                          return SizedBox(
                            width: dayColWidth,
                            height: hourRowHeight,
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: bookingsHere.isEmpty
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.03,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: Colors.white.withValues(
                                            alpha: 0.05,
                                          ),
                                        ),
                                      ),
                                    )
                                  : _BookedCell(bookings: bookingsHere),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  if (i < _endHour - _startHour - 1)
                    const Divider(color: Colors.white10, height: 1, indent: 44),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _emptySchedule(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.calendar_today_outlined,
                size: 36,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No bookings this week'.tr,
              style: TextStyle(
                color:
                    Theme.of(context).textTheme.bodyMedium?.color ??
                    Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Approved and pending reservations\nwill appear here.'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatHour(int h) {
    if (h == 0 || h == 24) return '12 AM';
    if (h < 12) return '$h AM';
    if (h == 12) return '12 PM';
    return '${h - 12} PM';
  }

  String _formatDate(DateTime d) => '${d.day}/${d.month}';
}

// ─── Single booked cell ────────────────────────────────────────────────────────
class _BookedCell extends StatelessWidget {
  final List<BookingEntity> bookings;
  const _BookedCell({required this.bookings});

  @override
  Widget build(BuildContext context) {
    final first = bookings.first;
    final isPending = first.status == BookingStatus.pending;
    final color = isPending ? Colors.orange : AppColors.primaryColor;

    return GestureDetector(
      onTap: () => _showDetail(context),
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withValues(alpha: 0.55), width: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPending
                  ? Icons.hourglass_top_rounded
                  : Icons.check_circle_outline_rounded,
              color: color,
              size: 14,
            ),
            if (bookings.length > 1)
              Text(
                '+${bookings.length}',
                style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _BookingDetailSheet(bookings: bookings),
    );
  }
}

// ─── Bottom-sheet detail ───────────────────────────────────────────────────────
class _BookingDetailSheet extends StatelessWidget {
  final List<BookingEntity> bookings;
  const _BookingDetailSheet({required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          ...bookings.map((b) => _DetailRow(booking: b)),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final BookingEntity booking;
  const _DetailRow({required this.booking});

  @override
  Widget build(BuildContext context) {
    final isPending = booking.status == BookingStatus.pending;
    final statusColor = isPending ? Colors.orange : AppColors.primaryColor;
    final statusLabel = isPending ? 'Pending'.tr : 'Approved'.tr;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryColor.withValues(alpha: 0.2),
            backgroundImage: booking.avatarUrl.isNotEmpty
                ? NetworkImage(booking.avatarUrl)
                : null,
            child: booking.avatarUrl.isEmpty
                ? const Icon(Icons.person, color: Colors.white54, size: 20)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.playerName,
                  style: TextStyle(
                    color:
                        Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${booking.dateTime}  •  ${booking.duration}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: statusColor.withValues(alpha: 0.45),
                width: 1,
              ),
            ),
            child: Text(
              statusLabel,
              style: TextStyle(
                color: statusColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Legend dot ───────────────────────────────────────────────────────────────
class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ],
    );
  }
}

// ─── Skeleton Loading ──────────────────────────────────────────────────────────
class _CourtProfileSkeleton extends StatefulWidget {
  const _CourtProfileSkeleton();

  @override
  State<_CourtProfileSkeleton> createState() => _CourtProfileSkeletonState();
}

class _CourtProfileSkeletonState extends State<_CourtProfileSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heroHeight = MediaQuery.of(context).size.height * 0.30;

    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        final opacity = 0.12 + (_anim.value * 0.15);
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              _SkeletonBox(height: heroHeight, opacity: opacity, radius: 0),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _SkeletonBox(
                            height: 48,
                            opacity: opacity,
                            radius: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SkeletonBox(
                            height: 48,
                            opacity: opacity,
                            radius: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _SkeletonBox(height: 46, opacity: opacity, radius: 12),
                    const SizedBox(height: 20),
                    _SkeletonBox(height: 120, opacity: opacity, radius: 16),
                    const SizedBox(height: 16),
                    _SkeletonBox(height: 140, opacity: opacity, radius: 16),
                    const SizedBox(height: 16),
                    _SkeletonBox(height: 170, opacity: opacity, radius: 16),
                    const SizedBox(height: 16),
                    _SkeletonBox(height: 100, opacity: opacity, radius: 16),
                    const SizedBox(height: 16),
                    _SkeletonBox(height: 100, opacity: opacity, radius: 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double height;
  final double opacity;
  final double radius;

  const _SkeletonBox({
    required this.height,
    required this.opacity,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: opacity),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

// ─── Error State ───────────────────────────────────────────────────────────────
class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.cloud_off_outlined,
                size: 44,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Something went wrong'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: Text(
                  'Try Again'.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
