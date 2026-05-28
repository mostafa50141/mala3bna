# Implementation Plan: Nearby Courts Map

**Branch**: `001-nearby-courts-map` | **Date**: May 28, 2026 | **Spec**: specs/001-nearby-courts-map/spec.md
**Input**: Feature specification from prompt

## Summary

Add a map section to the Player Home Screen that shows the user's current location and nearby courts as markers using flutter_map with OpenStreetMap. 

## Technical Context

**Language/Version**: Dart (Flutter SDK)
**Primary Dependencies**: flutter_map: ^6.1.0, latlong2: ^0.9.0, geolocator: ^11.0.0, geocoding: ^3.0.0
**Storage**: N/A 
**Testing**: Flutter tests
**Target Platform**: Android, iOS
**Project Type**: Mobile App
**Performance Goals**: Smooth map interaction
**Constraints**: Requires device location permissions. Free OSM tile server.
**Scale/Scope**: Local map segment on home screen.

## Constitution Check

All principles passed.

## Project Structure

### Documentation (this feature)
specs/001-nearby-courts-map/
├── plan.md              
├── research.md          
├── data-model.md        
└── quickstart.md

### Source Code
lib/features/player/home/data/models/court_model.dart (edit)
lib/features/player/home/presentation/views/widgets/home_view_body.dart (edit)
lib/features/player/home/presentation/views/widgets/courts_map_section.dart (create)
lib/features/player/home/presentation/views/widgets/court_map_marker.dart (create)
pubspec.yaml (edit)
android/app/src/main/AndroidManifest.xml (edit)
