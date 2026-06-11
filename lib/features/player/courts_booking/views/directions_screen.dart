import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/core/utils/route_service.dart';
import 'package:mala3bna/core/utils/location_service.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';
import 'package:mala3bna/core/widgets/custome_circular_laoding.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/court_map_marker.dart';

class DirectionsScreen extends StatefulWidget {
  final CourtModel court;

  const DirectionsScreen({super.key, required this.court});

  @override
  State<DirectionsScreen> createState() => _DirectionsScreenState();
}

class _DirectionsScreenState extends State<DirectionsScreen> {
  bool _isLoading = true;
  String _loadingMessage = 'Checking permissions...';
  String? _errorMessage;
  bool _routeFailed = false;
  LatLng? _userLocation;
  List<LatLng> _routePoints = [];
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _initDirections();
  }

  Future<void> _initDirections() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _loadingMessage = 'Initializing navigation...';
    });

    try {
      // 1. Validate court coordinates
      if (widget.court.lat == 0.0 && widget.court.lng == 0.0) {
        throw Exception(
          'Invalid court coordinates. Cannot calculate directions.',
        );
      }

      // 2. Check location services & permissions via LocationService
      setState(() => _loadingMessage = 'Getting your location...');
      final locationService = getIt.get<LocationService>();
      final locationResult = await locationService.getUserLocation();

      if (!locationResult.isSuccess) {
        throw Exception(
          locationResult.errorMessage ?? 'Could not get location',
        );
      }
      final userLoc = locationResult.location!;

      // 5. Fetch route coordinates
      setState(() => _loadingMessage = 'Finding the best route...');
      final routeService = getIt.get<RouteService>();
      final result = await routeService.fetchRoute(
        start: userLoc,
        end: LatLng(widget.court.lat, widget.court.lng),
      );

      result.fold(
        (failure) {
          // Route failed but we still have user location - show map without route
          setState(() {
            _userLocation = userLoc;
            _routePoints = []; // empty route
            _routeFailed = true;
            _isLoading = false;
          });
        },
        (points) {
          setState(() {
            _userLocation = userLoc;
            _routePoints = points;
            _isLoading = false;
          });
        },
      );

      // Fit camera bounds after widgets are fully rendered
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _fitMapBounds();
      });
    } catch (e) {
      String msg = e.toString();
      if (msg.startsWith('Exception: ')) {
        msg = msg.replaceFirst('Exception: ', '');
      }
      setState(() {
        _errorMessage = msg;
        _isLoading = false;
      });
    }
  }

  void _fitMapBounds() {
    if (_userLocation == null) return;
    try {
      final bounds = LatLngBounds.fromPoints([
        _userLocation!,
        LatLng(widget.court.lat, widget.court.lng),
      ]);
      _mapController.fitCamera(
        CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(80)),
      );
    } catch (e) {
      print('Error fitting camera bounds: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Directions',
          style: Style.textStyle20Bold.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomeCircularLaoding(),
            const Gap(24),
            Text(
              _loadingMessage,
              style: Style.textStyle16.copyWith(
                color: Colors.white70,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_off_rounded,
                  color: Colors.redAccent,
                  size: 48,
                ),
              ),
              const Gap(20),
              Text(
                'Navigation Error',
                style: Style.textStyle18Bold.copyWith(color: Colors.white),
              ),
              const Gap(10),
              Text(
                _errorMessage!,
                style: Style.textStyle14.copyWith(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const Gap(30),
              ElevatedButton.icon(
                onPressed: _initDirections,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                icon: const Icon(Icons.replay_rounded, size: 20),
                label: Text(
                  'Retry Now',
                  style: Style.textStyle14Bold.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Success State
    return Stack(
      children: [
        // 1. Fullscreen Map View
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _userLocation ?? const LatLng(30.0444, 31.2357),
            initialZoom: 14.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.mala3bna',
            ),
            // Glowing route Polyline
            PolylineLayer(
              polylines: [
                if (_routePoints.isNotEmpty)
                  Polyline(
                    points: _routePoints,
                    strokeWidth: 5.0,
                    color: AppColors.primaryColor,
                    borderStrokeWidth: 1.5,
                    borderColor: AppColors.primaryColor.withOpacity(0.4),
                    strokeCap: StrokeCap.round,
                    strokeJoin: StrokeJoin.round,
                  ),
              ],
            ),
            // Location Markers
            MarkerLayer(
              markers: [
                // 1. User Location Marker
                if (_userLocation != null)
                  Marker(
                    point: _userLocation!,
                    width: 44,
                    height: 44,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Subtle pulsing glow
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.withOpacity(0.2),
                          ),
                        ),
                        // Inner marker body
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2.5),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.navigation,
                            color: Colors.white,
                            size: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                // 2. Court Marker
                Marker(
                  point: LatLng(widget.court.lat, widget.court.lng),
                  width: 44,
                  height: 44,
                  child: CourtMapMarker(
                    court: widget.court,
                    onTap: () {
                      // Show snackbar / info about the court
                      Get.rawSnackbar(
                        titleText: Text(
                          widget.court.name,
                          style: Style.textStyle14Bold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        messageText: Text(
                          widget.court.location,
                          style: Style.textStyle12.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                        backgroundColor: AppColors.colorBtnAndCard,
                        margin: const EdgeInsets.all(16),
                        borderRadius: 12,
                        duration: const Duration(seconds: 3),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),

        if (_routeFailed)
          Positioned(
            top: MediaQuery.of(context).padding.top + 70,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.white, size: 18),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      'Route unavailable — showing court location only',
                      style: Style.textStyle12.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),

        // 2. Floating action buttons (e.g. Fit Camera, Recenter)
        Positioned(
          top: 16,
          right: 16,
          child: Column(
            children: [
              FloatingActionButton.small(
                heroTag: 'fit_bounds_btn',
                onPressed: _fitMapBounds,
                backgroundColor: AppColors.colorBtnAndCard,
                foregroundColor: AppColors.primaryColor,
                elevation: 4,
                child: const Icon(Icons.zoom_out_map_rounded),
              ),
              const Gap(10),
              if (_userLocation != null)
                FloatingActionButton.small(
                  heroTag: 'my_location_btn',
                  onPressed: () {
                    _mapController.move(_userLocation!, 15.5);
                  },
                  backgroundColor: AppColors.colorBtnAndCard,
                  foregroundColor: Colors.blue,
                  elevation: 4,
                  child: const Icon(Icons.my_location),
                ),
            ],
          ),
        ),

        // 3. Premium Glassmorphic Bottom Info Panel
        Positioned(
          bottom: 24,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.colorBtnAndCard.withOpacity(0.92),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.08),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.sports_tennis_rounded,
                        color: AppColors.primaryColor,
                        size: 24,
                      ),
                    ),
                    const Gap(14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.court.name,
                            style: Style.textStyle16Bold.copyWith(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Gap(3),
                          Text(
                            widget.court.sport.capitalizeFirst ??
                                widget.court.sport,
                            style: Style.textStyle12Bold.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                const Divider(color: Colors.white10, height: 1),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.redAccent,
                            size: 18,
                          ),
                          const Gap(6),
                          Expanded(
                            child: Text(
                              widget.court.location,
                              style: Style.textStyle12.copyWith(
                                color: Colors.white70,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.court.distance,
                      style: Style.textStyle14Bold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
