# Phase 0: Outline & Research

## Technical Decisions

**Decision**: Use `flutter_map` instead of `google_maps_flutter`
**Rationale**: OpenStreetMap requires no API keys, which fits the static dummy data constraint and avoids external billing configuration during early development.

**Decision**: Handled User Permissions Locally in `CourtsMapSection` (Stateful Widget)
**Rationale**: Standard practice utilizing `geolocator` handles the location requests optimally without congesting the BLoC/Cubit purely mapped to the court list domains.

**Decision**: Fallback Coordinate Default
**Rationale**: If a user declines permissions or location is turned off, providing Cairo coordinates (lat 30.0444, lng 31.2357) prevents map crashes and provides contextual relevance based on the static data locations.

## Dependencies

- **`flutter_map` (^6.1.0)**: Open-source mapping.
- **`latlong2` (^0.9.0)**: Coordinate handling logic utilized by flutter_map.
- **`geolocator` (^11.0.0)**: Determine the current user's location securely.
- **`geocoding` (^3.0.0)**: Address resolution tooling.
