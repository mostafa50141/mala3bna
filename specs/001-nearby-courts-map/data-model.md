# Phase 1: Data Model Updates

## Modified Entities

### `CourtModel`

The existing `CourtModel` in `lib/features/player/home/data/models/court_model.dart` needs modification to include layout coordinates.

```dart
class CourtModel {
  // Existing fields...
  final String? id;
  final String? name;
  final String? location;
  // ...
  
  // NEW FIELDS:
  final double? lat;
  final double? lng;
  
  // Updates to constructor, fromJson, and toJson to support lat/lng.
}
```

## Hardcoded Repo Updates

The `CourtsRepoImpl` class must assign accurate temporary static coordinates aligned to realistic locations around Cairo for the existing courts.

| Court Name | Latitude | Longitude |
|------------|----------|-----------|
| Smash Padel Club | 30.0626 | 31.2497 |
| Ace Tennis Arena | 30.0682 | 31.3279 |
| Blue Wave Swimming | 29.9626 | 31.2497 |
| Grand Padel Court | 30.0875 | 31.3411 |
| Elite Tennis Club | 30.0392 | 31.2133 |
| Al Ahly Football | 30.0682 | 31.3279 |
| Zamalek Football | 30.0626 | 31.2497 |
