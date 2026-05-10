---
description: "Task list for Player Settings Screen implementation"
---

# Tasks: Player Settings Screen

**Input**: Design documents from `/specs/003-player-settings/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [ ] T001 Create settings feature folders at lib/features/player/settings/views/widgets/
  - **Acceptance check**: Folder structure exists and is ready for widget files.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Reusable widgets required before the Settings screen body can be assembled

- [ ] T002 [P] Create SettingsTile in lib/features/player/settings/views/widgets/settings_tile.dart
  - **Acceptance check**: Widget renders icon, title, and optional trailing widget; supports optional icon/text color overrides.

- [ ] T003 [P] Create SettingsSwitchTile in lib/features/player/settings/views/widgets/settings_switch_tile.dart
  - **Acceptance check**: Widget renders icon, title, and a Switch with local `setState` for visual toggling.

- [ ] T004 [P] Create SettingsSection in lib/features/player/settings/views/widgets/settings_section.dart
  - **Acceptance check**: Widget renders a section title and a styled container using `AppColors.colorBtnAndCard` wrapping provided tiles.

**Checkpoint**: Foundational widgets are ready; the Settings body can be assembled.

---

## Phase 3: User Story 1 - Navigate and View Settings (Priority: P1) 🎯 MVP

**Goal**: As a player, I want to access my settings screen from my profile so that I can view available account, preference, and security options.

**Independent Test**: Can be fully tested by launching the app, navigating to the Profile tab, tapping the "Settings" menu option, and observing the layout, sections, and back navigation.

### Implementation for User Story 1

- [ ] T005 [US1] Build SettingsBody in lib/features/player/settings/views/widgets/settings_body.dart
  - **Acceptance check**: Renders Account, Preferences, and Danger Zone sections with static dummy tiles and a notifications switch. Uses `SettingsSection`, `SettingsTile`, and `SettingsSwitchTile`.
  - **Dependency**: Requires T002, T003, T004.

- [ ] T006 [US1] Build SettingsView in lib/features/player/settings/views/settings_view.dart
  - **Acceptance check**: AppBar includes back arrow and "Settings" title; body uses `SettingsBody`.
  - **Dependency**: Requires T005.

- [ ] T007 [US1] Wire Settings navigation in lib/features/player/profile/views/widgets/profile_body.dart
  - **Acceptance check**: Tapping "Settings" navigates to `SettingsView` via `Get.to(() => const SettingsView())`.
  - **Dependency**: Requires T006.

**Checkpoint**: The Settings screen is fully navigable and visually complete with static UI.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS user story tasks
- **User Story 1 (Phase 3)**: Depends on Foundational completion

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) completes

### Parallel Opportunities

- T002, T003, T004 can run in parallel (separate widget files).

---

## Parallel Example: User Story 1

```bash
# After Phase 2 completes
# Developer A
implement settings_body.dart

# Developer B
implement settings_view.dart
```
