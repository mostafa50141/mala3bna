import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/location_service.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custom_circular_loading.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';
import 'package:mala3bna/features/player/home/presentation/view_model/courts_cubit/courts_cubit.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/court_map_marker.dart';
import 'package:mala3bna/features/player/courts_booking/views/court_details.dart';

class MapBody extends StatefulWidget {
  const MapBody({super.key});

  @override
  State<MapBody> createState() => _MapBodyState();
}

class _MapBodyState extends State<MapBody> {
  static const LatLng _defaultCenter = LatLng(29.3084, 30.8428);

  LatLng _userLocation = _defaultCenter;
  bool _isLoading = true;
  bool _permissionDenied = false;
  CourtModel? _selectedCourt;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final result = await getIt.get<LocationService>().getUserLocation();
    setState(() {
      if (result.isSuccess) {
        _userLocation = result.location!;
      } else if (result.isPermissionDenied) {
        _permissionDenied = true;
      }
      _isLoading = false;
    });
    if (result.isSuccess) {
      _mapController.move(_userLocation, 14.0);
    }
  }

  void _onCourtTapped(CourtModel court) {
    setState(() => _selectedCourt = court);
    _mapController.move(LatLng(court.lat, court.lng), 14.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // 1. Full screen map
          BlocBuilder<CourtsCubit, CourtsState>(
            builder: (context, state) {
              final courts = state is CourtsSuccess
                  ? state.courts
                  : <CourtModel>[];
              final validCourts = courts
                  .where((c) => c.lat != 0.0 && c.lng != 0.0)
                  .toList();
              return FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _userLocation,
                  initialZoom: 12.0,
                  onTap: (_, __) => setState(() => _selectedCourt = null),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.mala3bna',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _userLocation,
                        width: 44,
                        height: 44,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2.5),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 6),
                            ],
                          ),
                          child: const Icon(
                            Icons.person_pin,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      ...validCourts.map(
                        (court) => Marker(
                          point: LatLng(court.lat, court.lng),
                          width: 44,
                          height: 44,
                          child: CourtMapMarker(
                            court: court,
                            onTap: () => _onCourtTapped(court),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),

          // 2. Loading overlay
          if (_isLoading)
            Container(
              color: AppColors.backgroundColor,
              child: const Center(child: CustomeCircularLaoding()),
            ),

          // 3. Permission denied overlay
          if (_permissionDenied)
            Container(
              color: AppColors.backgroundColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_off,
                      color: Colors.grey,
                      size: 60,
                    ),
                    const Gap(16),
                    Text(
                      'Location permission required',
                      style: Style.textStyle16Bold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      'Enable location to see nearby courts',
                      style: Style.textStyle14.copyWith(color: Colors.grey),
                    ),
                    const Gap(24),
                    ElevatedButton(
                      onPressed: _getUserLocation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Enable Location',
                        style: Style.textStyle14Bold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // 4. Top search bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.colorBtnAndCard,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 8),
                ],
              ),
              child: Row(
                children: [
                  const Gap(16),
                  const Icon(Icons.search, color: Colors.grey, size: 20),
                  const Gap(8),
                  Text(
                    'Search courts...',
                    style: Style.textStyle14.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          // 5. My location FAB
          Positioned(
            bottom: _selectedCourt != null ? 200 : 24,
            right: 16,
            child: FloatingActionButton.small(
              heroTag: 'map_tab_my_location',
              onPressed: () => _mapController.move(_userLocation, 14.0),
              backgroundColor: AppColors.colorBtnAndCard,
              foregroundColor: Colors.blue,
              elevation: 4,
              child: const Icon(Icons.my_location),
            ),
          ),

          // 6. Selected court bottom card
          if (_selectedCourt != null)
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.colorBtnAndCard,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black38, blurRadius: 16),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        _selectedCourt!.imageUrl,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _selectedCourt!.name,
                            style: Style.textStyle16Bold.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            _selectedCourt!.location,
                            style: Style.textStyle12.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          const Gap(4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                              const Gap(4),
                              Text(
                                '${_selectedCourt!.rating}',
                                style: Style.textStyle12.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              const Gap(8),
                              Text(
                                '${_selectedCourt!.pricePerHour} EGP/hr',
                                style: Style.textStyle12Bold.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Gap(8),
                    ElevatedButton(
                      onPressed: () => Get.to(
                        () => BookingsView(courtModel: _selectedCourt!),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        'Book',
                        style: Style.textStyle12Bold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
