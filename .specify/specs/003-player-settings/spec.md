# Feature Specification: Player Settings Screen

**Feature Branch**: `003-player-settings`  
**Created**: May 10, 2026  
**Status**: Draft  
**Input**: User description: "Feature: Player Settings Screen with Account, Preferences, and Danger Zone sections using static dummy data."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Navigate and View Settings (Priority: P1)

As a player, I want to access my settings screen from my profile so that I can view available account, preference, and security options.

**Why this priority**: It is the foundation for all settings sub-features and establishes the required routing, layout, and visual structure.

**Independent Test**: Can be fully tested by launching the app, navigating to the Profile tab, tapping the "Settings" menu option, and observing the layout, sections, and back navigation.

**Acceptance Scenarios**:

1. **Given** I am on the Profile screen, **When** I tap the "Settings" menu item, **Then** I am navigated to the Settings screen with a back arrow and "Settings" title in the AppBar.
2. **Given** I am on the Settings screen, **When** I scroll through the layout, **Then** I see the three sections: "Account", "Preferences", and "Danger Zone".
3. **Given** I am viewing the Preferences section, **When** I check the layout, **Then** I see functional-looking static toggles/selectors for Notifications, Language (English/Arabic), and Theme (Dark/Light).
4. **Given** I am viewing the Danger Zone section, **When** I check the layout, **Then** I see the "Delete Account" option styled distinctly with red text and a red icon.

---

### Edge Cases

- What happens when a toggle or setting tile is tapped? (For this static phase, nothing structural happens or a simple placeholder void function triggers, since there is no Cubit/State Management).
- Are language/theme switches actually modifying app state? (No, static dummy data phase only).

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST provide navigation from the "Settings" menu item in the existing `ProfileView` to the `SettingsView`.
- **FR-002**: The `SettingsView` MUST have an AppBar with a functional back arrow and a "Settings" title.
- **FR-003**: The screen MUST display an "Account" section containing "Edit Profile" (navigates to a placeholder/dummy edit profile route) and "Change Password".
- **FR-004**: The screen MUST display a "Preferences" section containing a Notifications toggle, Language selector, and Theme selector.
- **FR-005**: The screen MUST display a "Danger Zone" section containing a "Delete Account" action.
- **FR-006**: The "Delete Account" tile MUST be visually distinguished using a red icon and red text to signal a destructive action.
- **FR-007**: The implementation MUST mirror the design pattern used in `lib/features/owner/setting/` for consistency.
- **FR-008**: The UI MUST be implemented exclusively with static mock data (no Cubit/real API integration).
- **FR-009**: The implementation MUST strictly use colors defined in `AppColors` and typography from `Style`.

### Key Entities

- *No data models or persistent entities are required for this static UI phase.*

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: The Settings screen completely matches the provided UI sections and options (Account, Preferences, Danger Zone).
- **SC-002**: The transition from ProfileView to SettingsView occurs exactly when the "Settings" option is tapped.
- **SC-003**: No unexpected state management packages or Cubits are introduced.
- **SC-004**: Architecture constraints regarding the 5 specific requested files (`settings_view.dart`, `settings_body.dart`, `settings_section.dart`, `settings_tile.dart`, `settings_switch_tile.dart`) are strictly followed.

## Assumptions

- No functional state changes (like actually translating the app language or changing themes) need to occur during this static implementation phase.
- Existing standard components or standard Flutter widgets (like Switch) can be styled appropriately using `AppColors`.
- The 'Delete Account' and other critical actions will not execute actual workflows yet.
