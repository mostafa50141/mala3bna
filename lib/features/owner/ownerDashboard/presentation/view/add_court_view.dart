import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/features/owner/courts/domain/repositories/court_repository.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/cubit/add_court_cubit.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/cubit/add_court_state.dart';
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

  final ImagePicker _picker = ImagePicker();
  late final MultiImagePickerController _imageController;
  
  List<String> _selectedAmenities = [];

  @override
  void initState() {
    super.initState();
    _imageController = MultiImagePickerController(
      maxImages: 10,
      images: [],
      picker: (int pickCount, Object? params) async {
        final pickedFiles = await _picker.pickMultiImage();
        return pickedFiles
            .take(pickCount)
            .map((xFile) => convertXFileToImageFile(xFile))
            .toList();
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    final images = _imageController.images;
    final imagePaths = images.where((i) => i.hasPath).map((i) => i.path!).toList();

    context.read<AddCourtCubit>().submit(
      title: _nameController.text.trim(),
      hourlyRate: _priceController.text.trim(),
      address: _addressController.text.trim(),
      amenityIds: _selectedAmenities,
      imagePaths: imagePaths,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCourtCubit(getIt<CourtRepository>()),
      child: BlocConsumer<AddCourtCubit, AddCourtState>(
        listener: (context, state) {
          if (state is AddCourtSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Court created successfully!'.tr),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.maybePop(context, true); // true to indicate refresh needed
          } else if (state is AddCourtError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
              ),
            );
          } else if (state is AddCourtFormError) {
            final errorMsgs = state.errors.values.join('\n');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMsgs),
                backgroundColor: Colors.orange,
              ),
            );
          }
        },
        builder: (context, state) {
          final isSubmitting = state is AddCourtSubmitting;

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
                          SizedBox(
                            height: 220,
                            child: ImageUploadSection(controller: _imageController),
                          ),
                          const SizedBox(height: 20),
                          AmenitiesSection(
                            onAmenitiesChanged: (selected) {
                              _selectedAmenities = selected;
                            },
                          ),
                          const SizedBox(height: 28),

                          // Save button
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: isSubmitting ? null : () => _submit(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: isSubmitting
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.5,
                                      ),
                                    )
                                  : Text(
                                      'Save Court'.tr,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Cancel button
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: OutlinedButton(
                              onPressed: isSubmitting ? null : () => Navigator.maybePop(context),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white70,
                                side: BorderSide(color: Colors.white.withOpacity(0.15), width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Text(
                                'Cancel'.tr,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
              Expanded(
                child: Text(
                  'Add Your Court'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
