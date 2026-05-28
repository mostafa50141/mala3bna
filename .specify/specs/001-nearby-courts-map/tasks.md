# Tasks: Nearby Courts Map

## Phase 1: Setup

- [ ] T001 pubspec.yaml
  - **Action**: Add dependencies for mapping and geolocation (`flutter_map`, `latlong2`, `geolocator`, `geocoding`).
  - **Criteria**: App builds successfully and `pub get` runs without errors with new dependencies.
- [ ] T002 android/app/src/main/AndroidManifest.xml
  - **Action**: Add `<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />` and `<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />` to the manifest.
  - **Criteria**: App installs correctly and does not crash when requesting location on Android.

## Phase 2: Foundational

- [ ] T003 lib/features/player/home/data/models/court_model.dart
  - **Action**: Add `lat` and `lng` as optional `double` properties to `CourtModel` and update its JSON serialization/deserialization accordingly.
  - **Criteria**: `CourtModel` can parse new hardcoded data containing coordinate fields without error.
- [ ] T004 lib/features/player/home/data/repos/courts_repo_impl.dart
  - **Action**: Update the static courts backend placeholder values with realistic `lat` and `lng` data around Cairo (e.g. 30.x, 31.x).
  - **Criteria**: The app still runs and returns `CourtModel` instances successfully populated with latitude and longitude data.

## Phase 3: User Story 1 (Map UI Component)

- [ ] T005 [P] [US1] lib/features/player/home/presentation/views/widgets/court_map_marker.dart
  - **Action**: Create the visual map marker widget representing a single court ping with a styled icon or image.
  - **Criteria**: A visual flutter widget can be rendered for a given location on the map.
- [ ] T006 [US1] lib/features/player/home/presentation/views/widgets/courts_map_section.dart
  - **Action**: Build `CourtsMapSection` (Stateful Widget) which initializes `flutter_map`, manages `geolocator` location permissions, checks OS level device location, handles fallback logic, and overlays the user's location along with `MarkerLayer` array parsed from retrieved courts coordinates.
  - **Criteria**: The map UI element successfully renders with multiple markers, tracks a proper focal center, and asks the user for permission.
- [ ] T007 [US1] lib/features/player/home/presentation/views/widgets/home_view_body.dart
  - **Action**: Insert `CourtsMapSection` above or below the list/grid of courts in the Home UI block.
  - **Criteria**: Home view loads without breaking and scrolling correctly includes the interactive map element bridging the new feature to the active user interface.
