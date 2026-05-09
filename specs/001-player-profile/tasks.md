# Tasks: Player Profile Screen

**Input**: Design documents from `/specs/001-player-profile/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md

**Organization**: Tasks are grouped by user story to enable independent implementation.

## Phase 1: User Story 1 - View Player Profile (Priority: P1) 🎯 MVP

**Goal**: As a player, I want to access my profile screen so that I can see my personal information and quickly navigate to my account-related pages like bookings, settings, and payments.

**Independent Test**: Can be fully tested by navigating to the Profile tab and verifying all static UI elements (avatar, stats, menu items) render correctly without crashing.

### Implementation for User Story 1

- [x] T001 [P] [US1] Create Profile Menu Item Widget
  - **File path**: `lib/features/player/profile/views/widgets/profile_menu_item.dart`
  - **What it builds**: Reusable menu row widget with leading icon, text, and trailing chevron.
  - **Props/parameters**: `IconData icon`, `String title`, `VoidCallback onTap`, `Color? iconColor`, `Color? textColor`.
  - **Core widgets/styles**: `AppColors.colorBtnAndCard` (background), `AppColors.primaryColor` (default icon), `Styles`.
  - **Acceptance check**: A standalone row widget renders correctly with customized colors (e.g., standard color vs red for logout) and text.

- [x] T002 [P] [US1] Create Profile Stats Row Widget
  - **File path**: `lib/features/player/profile/views/widgets/profile_stats_row.dart`
  - **What it builds**: A horizontal row of three stat cards (Bookings, Favorite Sport, Member Since).
  - **Props/parameters**: `String bookingsCount`, `String favoriteSport`, `String memberSince`.
  - **Core widgets/styles**: `AppColors.colorBtnAndCard` (card background), `AppColors.primaryColor` (accent numbers), typography from `Style`.
  - **Acceptance check**: Widget displays three equally spaced or styled cards horizontally with provided string parameters clearly formatted.

- [x] T003 [US1] Assemble Profile Body
  - **File path**: `lib/features/player/profile/views/widgets/profile_body.dart`
  - **What it builds**: Assembles the avatar (green ring), name, email, `ProfileStatsRow`, and a list of `ProfileMenuItem`s.
  - **Props/parameters**: None (uses static dummy data internally).
  - **Core widgets/styles**: `AppColors.primaryColor` (for avatar ring), `CustomeCircularAvatar` (if exists natively) or standard `CircleAvatar`, `ProfileStatsRow`, `ProfileMenuItem`.
  - **Acceptance check**: View constructs the full screen content without the app bar. Avatar is centered, followed by text, the stats row, and the list of options (with Logout at the end marked red). *Depends on T001 and T002.*

- [x] T004 [US1] Replace Profile View Screen
  - **File path**: `lib/features/player/profile/views/profile_view.dart`
  - **What it builds**: Wraps `ProfileBody` in a `Scaffold` with an `AppBar` containing a back arrow and "Profile" title.
  - **Props/parameters**: None.
  - **Core widgets/styles**: `Scaffold`, `AppBar`, `AppColors.backgroundColor`, `ProfileBody`.
  - **Acceptance check**: The view no longer redirects instantly; it displays an app bar over the newly built `ProfileBody`, completing the UI replacement successfully. *Depends on T003.*

**Checkpoint**: At this point, User Story 1 is fully functional as a static UI layout replacement for the profile tab.
