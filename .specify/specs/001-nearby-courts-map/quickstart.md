# Quickstart for Developers

## Installation

1. Add dependencies to `pubspec.yaml`:
   ```yaml
   dependencies:
     flutter_map: ^6.1.0
     latlong2: ^0.9.0
     geolocator: ^11.0.0
     geocoding: ^3.0.0
   ```
2. Run `flutter pub get`.
3. Add permissions to `android/app/src/main/AndroidManifest.xml` and `ios/Runner/Info.plist`.

## Building the Map View

The widget `CourtsMapSection` (`lib/features/player/home/presentation/views/widgets/courts_map_section.dart`) controls map instances.

```dart
// Basic layout inside CourtsMapSection build tree
FlutterMap(
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
      markers: _buildCourtMarkers(courts),
    ),
  ],
)
```
