# Implementation Plan: Player Settings Screen

**Branch**: `003-player-settings` | **Date**: May 10, 2026 | **Spec**: [specs/003-player-settings/spec.md](specs/003-player-settings/spec.md)
**Input**: Feature specification from `/specs/003-player-settings/spec.md`

## Summary

Build a Settings UI for the Player role using static dummy data. The feature consists of three sections: Account, Preferences, and Danger Zone. It heavily reuses existing styling (`AppColors`, `Style`) and follows the widget pattern already established in the `owner/setting/` feature. The Notifications toggle requires local state (`setState`) to show interaction, entirely bypassing any Cubit or complex state management for now.

## Technical Context

**Language/Version**: Dart, Flutter SDK (`^3.9.0`)
**Primary Dependencies**: `get` for navigation
**Storage**: N/A
**Testing**: Opt-out
**Target Platform**: Android/iOS
**Project Type**: Mobile Application
**Performance Goals**: N/A
**Constraints**: Follow clean architecture structure precisely under `lib/features/player/settings/`. No Cubit or State Management packages allowed; use basic built-in local state (`setState`) for toggles.
**Scale/Scope**: 5 UI widget/view files

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Clean Architecture & Feature-First**: Passes. Uses `features/player/settings/`.
- **State Management (Cubit Only)**: Passes. No state management solution outside local component state (`setState` for toggle) is introduced.
- **Dependency Injection & Navigation**: Passes. Usage of `Get.to()` for navigation. No GoRouter.
- **Storage & UI Guidelines**: Passes. Only `AppColors` and `Style` used. 

## Target Files & Classes

1. `lib/features/player/settings/views/settings_view.dart`
   - **Class**: `SettingsView` (StatelessWidget)
   - Scaffold wrapper providing AppBar (back arrow + "Settings"). Includes `SettingsBody`.
2. `lib/features/player/settings/views/widgets/settings_body.dart`
   - **Class**: `SettingsBody` (StatelessWidget)
   - Arranges the sections using `SettingsSection`, `SettingsTile`, and `SettingsSwitchTile`.
3. `lib/features/player/settings/views/widgets/settings_section.dart`
   - **Class**: `SettingsSection` (StatelessWidget)
   - Component rendering a group title and a `Column` of tiles within a styled card/container. Reuses `AppColors.colorBtnAndCard`.
4. `lib/features/player/settings/views/widgets/settings_tile.dart`
   - **Class**: `SettingsTile` (StatelessWidget)
   - Reusable row for list items (Icon, Title, Trailing widget like an arrow). Must support optional `iconColor` and `textColor` (e.g., for standard text vs Danger Zone red).
5. `lib/features/player/settings/views/widgets/settings_switch_tile.dart`
   - **Class**: `SettingsSwitchTile` (StatefulWidget)
   - Implements a row with a title, icon, and a `Switch`. Uses `setState` locally to toggle the switch on/off visually since no Cubit is in place yet.

## Implementations Details

- **Navigation Integration**: In `lib/features/player/profile/views/widgets/profile_body.dart`, update the `ProfileMenuItem` for "Settings" to map `onTap` to `Get.to(() => const SettingsView())`.
- **Toggle State Handling**: `SettingsSwitchTile` will maintain a local `bool _isSwitched = false;` in its state class and toggle it via `setState(({_isSwitched = value;}))`.
- **Pattern Reuse**: The `owner/setting/` pattern employs standard cards encapsulating `ListTile` or similar rows. `SettingsSection` will construct the container with rounded corners and `AppColors.colorBtnAndCard` background, looping over passed `SettingsTile` elements. The danger zone tile uses a red icon/text override.
- **Static Selectors**: Language and Theme selectors will serve as standard `SettingsTile`s with a trailing text (like 'English' or 'Dark') and an arrow, opening empty dummy functions for now.

## Project Structure

### Documentation (this feature)

```text
specs/003-player-settings/
├── plan.md              # This file
├── research.md          
├── data-model.md        
├── quickstart.md        
├── contracts/           
└── tasks.md             
```

### Source Code
```text
lib/
└── features/
    └── player/
        └── settings/
            └── views/
                ├── settings_view.dart 
                └── widgets/
                    ├── settings_body.dart
                    ├── settings_section.dart
                    ├── settings_tile.dart
                    └── settings_switch_tile.dart
```