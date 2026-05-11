import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/edit_court_cubit.dart';
import 'package:mala3bna/features/owner/courts/presentation/cubit/edit_court_state.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/amenity_chip.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/dashed_add_photo.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/bottom_action_buttons.dart';
import 'package:mala3bna/features/owner/courts/data/datasources/court_remote_data_source.dart';
import 'package:mala3bna/features/owner/courts/data/repositories/court_repository_impl.dart';
import '../../data/models/court_model.dart';

class EditCourtScreen extends StatefulWidget {
  final String courtId;
  const EditCourtScreen({super.key, required this.courtId});

  @override
  State<EditCourtScreen> createState() => _EditCourtScreenState();
}

class _EditCourtScreenState extends State<EditCourtScreen> {
  late final EditCourtCubit _cubit;
  final _formKey = GlobalKey<FormState>();
  final _hourlyController = TextEditingController();
  final _selectedAmenities = <String>{};
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    final remote = CourtRemoteDataSourceImpl();
    final repo = CourtRepositoryImpl(remoteDataSource: remote);
    _cubit = EditCourtCubit(repository: repo);
    _cubit.loadCourt(widget.courtId);
  }

  @override
  void dispose() {
    _hourlyController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(),
          title: const Text('Edit Court Details'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocConsumer<EditCourtCubit, EditCourtState>(
            listener: (context, state) {
              if (state is EditCourtError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is EditCourtSuccess) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Court updated')));
              }

              // Initialize controllers and selections only once when data arrives
              if (state is EditCourtLoaded && !_initialized) {
                _initialized = true;
                // set controller value once (avoid doing this inside build)
                final hourly = state.court.hourlyRate.toStringAsFixed(0);
                if (_hourlyController.text != hourly) {
                  _hourlyController.text = hourly;
                }
                // initialize selected amenities without causing repeated rebuilds
                _selectedAmenities.addAll(
                  state.court.amenities.map((e) => e.id),
                );
                // No setState here: initial values are used by widgets on next build
              }
            },
            builder: (context, state) {
              if (state is EditCourtLoading || state is EditCourtInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is EditCourtLoaded) {
                final court = state.court;
                return _buildForm(
                  context,
                  court.copyWith(amenities: court.amenities),
                );
              }

              if (state is EditCourtImageUploading) {
                return const Center(child: CircularProgressIndicator());
              }

              return const Center(child: Text('Unexpected state'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, CourtModel court) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Court Photos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _buildPhotoGrid(court),
                const SizedBox(height: 20),
                const Text(
                  'Pricing',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _hourlyController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.colorBtnAndCard,
                    hintText: 'Hourly Rate (EGP/hr)',
                    hintStyle: TextStyle(color: AppColors.textFieldHint),
                    suffixText: 'EGP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Amenities',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _buildAmenities(court),
                const SizedBox(height: 20),
                const Text(
                  'Location',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _buildLocationPreview(court),
                const SizedBox(height: 28),
                BottomActionButtons(
                  onCancel: () => Navigator.of(context).pop(),
                  onSave: () async {
                    // prevent multiple taps
                    FocusScope.of(context).unfocus();
                    final amenityIds = court.amenities
                        .where((a) => _selectedAmenities.contains(a.id))
                        .map((e) => e.id)
                        .toList();
                    final lat = court.lat ?? 0.0;
                    final lng = court.lng ?? 0.0;
                    await context.read<EditCourtCubit>().saveChanges(
                      hourlyRate: _hourlyController.text,
                      amenityIds: amenityIds,
                      lat: lat,
                      lng: lng,
                    );
                  },
                  isSaving: context.select(
                    (EditCourtCubit c) => c.state is EditCourtSaving,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhotoGrid(CourtModel court) {
    final images = court.images;
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          if (index == images.length) {
            return GestureDetector(
              onTap: () async {
                // placeholder: use sample asset path to simulate pick
                final samplePath = 'assets/images/sample_court_1.jpg';
                await context.read<EditCourtCubit>().pickAndUploadImage(
                  samplePath,
                );
              },
              child: const DashedAddPhoto(),
            );
          }

          final img = images[index];
          return Stack(
            children: [
              RepaintBoundary(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image(
                    image: ResizeImage(
                      AssetImage(img.url),
                      // small multiplier to match pixel density; keeps memory low
                      width: 240,
                      height: 240,
                    ),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: () =>
                      context.read<EditCourtCubit>().removeImage(img.id),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAmenities(CourtModel court) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: court.amenities.map((amenity) {
        final selected = _selectedAmenities.contains(amenity.id);
        return AmenityChip(
          amenity: amenity,
          selected: selected,
          onTap: () {
            setState(() {
              if (selected)
                _selectedAmenities.remove(amenity.id);
              else
                _selectedAmenities.add(amenity.id);
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildLocationPreview(CourtModel court) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.colorBtnAndCard,
          ),
          child: const Center(
            child: Icon(Icons.map, color: Colors.white54, size: 48),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                'Location: ${court.lat?.toStringAsFixed(4) ?? '-'}, ${court.lng?.toStringAsFixed(4) ?? '-'}',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Change location not implemented'),
                  ),
                );
              },
              child: const Text('Change'),
            ),
          ],
        ),
      ],
    );
  }
}
