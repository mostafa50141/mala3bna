# Implementation Plan: Player Profile Screen

**Branch**: `001-player-profile` | **Date**: May 9, 2026 | **Spec**: [specs/001-player-profile/spec.md](specs/001-player-profile/spec.md)
**Input**: Feature specification from `/specs/001-player-profile/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Build a static UI layout for the Player Profile Screen replacing the existing routing behavior in `ProfileView`. The setup implements a defined UI spec containing a custom AppBar, avatar, stat cards, and a vertical settings menu.

## Technical Context

**Language/Version**: Dart with Flutter (SDK ^3.9.0)  
**Primary Dependencies**: `get` (if needed for nav, though not required for static UI layout), `AppColors`  
**Storage**: N/A  
**Testing**: N/A for this phase  
**Target Platform**: Android/iOS  
**Project Type**: Mobile App
**Performance Goals**: N/A (Static layout)
**Constraints**: strictly use static UI only. Strict path: `lib/features/player/profile/views/`
**Scale/Scope**: 4 files  

## Target Files

| File | Purpose |
|------|---------|
| `lib/features/player/profile/views/profile_view.dart` | Main screen definition, replacing the previous redirect logic. Holds the `Scaffold` and Top `AppBar` with back button, and renders `ProfileBody`. |
| `lib/features/player/profile/views/widgets/profile_body.dart` | Represents the main content of the profile screen. Renders avatar (with green ring), name, email, stats row, and the list of menu items. |
| `lib/features/player/profile/views/widgets/profile_stats_row.dart` | Reusable widget to display the three stat cards (Bookings, Favorite Sport, Member Since) horizontally. |
| `lib/features/player/profile/views/widgets/profile_menu_item.dart` | Reusable widget representing individual rows in the menu list. Accepts icons, title, colors, and an `onTap` callback. |

## Widget Tree Structure

```text
ProfileView (Scaffold)
 ├── AppBar
 │    ├── Leading: Back Arrow
 │    └── Title: "Profile"
 └── Body: ProfileBody
      └── ListView / Column
           ├── CircleAvatar with green border
           ├── Text (Name)
           ├── Text (Email)
           ├── ProfileStatsRow (Row component)
           │    ├── Stat Card: Bookings
           │    ├── Stat Card: Sport
           │    └── Stat Card: Membership
           ├── ProfileMenuItem ("My Bookings")
           ├── ProfileMenuItem ("Payments")
           ├── ProfileMenuItem ("Settings")
           ├── ProfileMenuItem ("Help")
           ├── ProfileMenuItem ("Terms")
           └── ProfileMenuItem ("Logout" -> specifically colored red)
```

## Props for Custom Widgets

**`ProfileStatsRow`:**
- `String bookingsCount`
- `String favoriteSport`
- `String memberSince`

**`ProfileMenuItem`:**
- `IconData icon` (The leading icon)
- `String title` (The label text)
- `VoidCallback onTap` (Tap handler)
- `Color? iconColor` (Default `AppColors.primaryColor`, red for logout)
- `Color? textColor` (Default font color, red for logout)

## Order of Implementation

1. Build `ProfileMenuItem` (`profile_menu_item.dart`)
2. Build `ProfileStatsRow` (`profile_stats_row.dart`)
3. Build `ProfileBody` (`profile_body.dart`), incorporating the above widgets and the Avatar snippet.
4. Replace `ProfileView` (`profile_view.dart`), scaffolding the overall app bar layout and injecting `ProfileBody`.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

[Gates determined based on constitution file]

## Project Structure

### Documentation (this feature)

```text
specs/[###-feature]/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)
<!--
  ACTION REQUIRED: Replace the placeholder tree below with the concrete layout
  for this feature. Delete unused options and expand the chosen structure with
  real paths (e.g., apps/admin, packages/something). The delivered plan must
  not include Option labels.
-->

```text
# [REMOVE IF UNUSED] Option 1: Single project (DEFAULT)
src/
├── models/
├── services/
├── cli/
└── lib/

tests/
├── contract/
├── integration/
└── unit/

# [REMOVE IF UNUSED] Option 2: Web application (when "frontend" + "backend" detected)
backend/
├── src/
│   ├── models/
│   ├── services/
│   └── api/
└── tests/

frontend/
├── src/
│   ├── components/
│   ├── pages/
│   └── services/
└── tests/

# [REMOVE IF UNUSED] Option 3: Mobile + API (when "iOS/Android" detected)
api/
└── [same as backend above]

ios/ or android/
└── [platform-specific structure: feature modules, UI flows, platform tests]
```

**Structure Decision**: [Document the selected structure and reference the real
directories captured above]

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |
