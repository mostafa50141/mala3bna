import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/amenities_section.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/basic_details_section.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/image_upload_section.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/location_section.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/pricing_photo_section.dart';

class AddCourtView extends StatefulWidget {
  const AddCourtView({super.key});

  @override
  State<AddCourtView> createState() => _AddCourtViewState();
}

class _AddCourtViewState extends State<AddCourtView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          // ── Custom header ─────────────────────────────────────────
          _buildHeader(context),

          // ── Scrollable form body ──────────────────────────────────
          Expanded(
            child: SafeArea(
              top: false,
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    BasicDetailsSection(nameController: _nameController),
                    const SizedBox(height: 20),
                    LocationSection(addressController: _addressController),
                    const SizedBox(height: 20),
                    PricingAndPhotoSection(priceController: _priceController),
                    const SizedBox(height: 8),
                    SizedBox(height: 220, child: ImageUploadSection()),
                    const SizedBox(height: 20),
                    const AmenitiesSection(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryColor.withOpacity(0.15),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 20),
                onPressed: () => Navigator.maybePop(context),
              ),
              const Expanded(
                child: Text(
                  'Add Your Court',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              // Placeholder to balance the back button
              const SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }
}
