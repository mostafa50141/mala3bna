import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/widgets/custom_circular_loading.dart';
import 'package:mala3bna/features/player/courts_booking/views/court_details.dart';
import 'package:mala3bna/features/player/home/data/models/court_model.dart';
import 'package:mala3bna/features/player/home/presentation/views/widgets/court_map_marker.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class CourtsMapSection extends StatefulWidget {
  final List<CourtModel> courts;

  const CourtsMapSection({super.key, required this.courts});

  @override
  State<CourtsMapSection> createState() => _CourtsMapSectionState();
}

class _CourtsMapSectionState extends State<CourtsMapSection> {
  LatLng _userLocation = const LatLng(30.0444, 31.2357); // Cairo default
  bool _isLoading = true;
  bool _permissionDenied = false;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _permissionDenied = true;
          _isLoading = false;
        });
        return;
      }
      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.colorBtnAndCard,
      ),
      clipBehavior: Clip.hardEdge,
      child: _isLoading
          ? const Center(child: CustomeCircularLaoding())
          : _permissionDenied
          ? Center(
              child: Text(
                'Enable location to see nearby courts',
                style: Style.textStyle14.copyWith(color: Colors.grey),
              ),
            )
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _userLocation,
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.mala3bna',
                ),
                MarkerLayer(
                  markers: [
                    // User location marker
                    Marker(
                      point: _userLocation,
                      width: 40,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.person_pin,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    // Court markers
                    ...widget.courts.map(
                      (court) => Marker(
                        point: LatLng(court.lat, court.lng),
                        width: 40,
                        height: 40,
                        child: CourtMapMarker(
                          court: court,
                          onTap: () =>
                              Get.to(() => BookingsView(courtModel: court)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
