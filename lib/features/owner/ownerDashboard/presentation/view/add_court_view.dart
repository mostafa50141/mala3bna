import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
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
      appBar: AppBar(
        title: Center(child: const Text("Add Your Court")),
        backgroundColor: AppColors.backgroundColor,
        scrolledUnderElevation: 0,
        titleTextStyle: Style.textStyle26.copyWith(fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            children: [
              BasicDetailsSection(nameController: _nameController),
              const SizedBox(height: 16),
              LocationSection(addressController: _addressController),
              const SizedBox(height: 24),
              PricingAndPhotoSection(priceController: _priceController),
              const SizedBox(height: 4),
              SizedBox(height: 200, child: ImageUploadSection()),
              const SizedBox(height: 24),
              const AmenitiesSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
