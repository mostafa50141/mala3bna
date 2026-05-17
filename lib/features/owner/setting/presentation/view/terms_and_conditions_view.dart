import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/terms_cubit.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/terms_state.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/terms_accept_button.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/terms_header_banner.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/terms_section_list.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TermsCubit(),
      child: const _TermsBody(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Body — scroll listener + layout orchestration
// ─────────────────────────────────────────────────────────────────────────────

class _TermsBody extends StatefulWidget {
  const _TermsBody();

  @override
  State<_TermsBody> createState() => _TermsBodyState();
}

class _TermsBodyState extends State<_TermsBody> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // Unlock the accept button when the user reaches 85% of the scrollable area.
  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent * 0.85) {
      context.read<TermsCubit>().onScrolledToBottom();
    }
  }

  void _onStateChanged(BuildContext context, TermsState state) {
    if (state.status == TermsStatus.accepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text(
                'Terms accepted!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
        ),
      );
      Future.delayed(
        const Duration(milliseconds: 600),
        () {
          if (context.mounted) Navigator.of(context).pop();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(context),
      body: BlocListener<TermsCubit, TermsState>(
        listener: _onStateChanged,
        child: Column(
          children: [
            // ── Scrollable content ──
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                physics: const BouncingScrollPhysics(),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero banner
                    TermsHeaderBanner(),
                    SizedBox(height: 24),

                    // Section label
                    _SectionLabel(),
                    SizedBox(height: 16),

                    // Expandable section cards
                    TermsSectionList(),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),

            // ── Sticky accept button ──
            BlocBuilder<TermsCubit, TermsState>(
              builder: (context, state) {
                return TermsAcceptButton(
                  canAccept: state.canAccept,
                  isLoading: state.status == TermsStatus.accepting,
                  onAccept: () => context.read<TermsCubit>().accept(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.white,
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Terms & Conditions',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            // TODO: share/export terms as PDF
          },
          icon: Icon(
            Icons.share_outlined,
            color: Colors.white.withValues(alpha: 0.5),
            size: 20,
          ),
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Inline private label widget (too small to warrant its own file)
// ─────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'SECTIONS',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.3,
          ),
        ),
      ],
    );
  }
}
