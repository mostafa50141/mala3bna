# Feature Specification: Player Profile Screen

**Feature Branch**: `001-player-profile`  
**Created**: May 9, 2026  
**Status**: Draft  
**Input**: User description: "Context: Read .specify/memory/constitution.md and .specify/memory/codebase.md first. Feature: Player Profile Screen. The current ProfileView at lib/features/player/profile/views/profile_view.dart redirects directly to MyBookingsViews. Replace it with a real profile screen..."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - View Player Profile (Priority: P1)

As a player, I want to access my profile screen so that I can see my personal information and quickly navigate to my account-related pages like bookings, settings, and payments.

**Why this priority**: Without a profile screen, users cannot easily navigate to secondary features or know their current session context. It acts as a central hub.

**Independent Test**: Can be fully tested by launching the app, navigating to the Profile tab, and verifying all static UI elements (avatar, stats, menu items) render correctly without crashing.

**Acceptance Scenarios**:

1. **Given** I am logged in as a player, **When** I tap on the Profile tab, **Then** I should see my profile picture with a green ring, my name, and my email.
2. **Given** I am on the Profile screen, **When** I view my statistics, **Then** I should see exactly three stat cards (Bookings count, Favorite sport, Member since year).
3. **Given** I am on the Profile screen, **When** I scroll through the menu, **Then** I should see "My Bookings", "Payments", "Settings", "Help", "Terms", and "Logout" rows.
4. **Given** I am viewing the Logout row, **When** I look at its styling, **Then** the text and icon should be displayed in red to signify a destructive action.

---

### Edge Cases

- What happens if a user's name or email is exceptionally long? (Text should truncate with ellipses to prevent layout breaking).
- How does the screen render on small screen devices? (The menu list should naturally scroll).

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST render a top app bar with a back arrow and a "Profile" title.
- **FR-002**: The system MUST display a circular avatar wrapped in a green ring, followed by the user's name and email address.
- **FR-003**: The system MUST display three statistics cards in a single row representing: Bookings count, Favorite sport, and Member since year.
- **FR-004**: The system MUST display a vertical menu list containing the following navigation options: My Bookings, Payments, Settings, Help, and Terms.
- **FR-005**: Every standard menu item MUST include a leading circular green icon container, a text label, and a trailing chevron arrow icon.
- **FR-006**: The system MUST display a "Logout" row at the bottom of the menu with a red-colored icon and red-colored text to distinguish it clearly from navigation options.
- **FR-007**: The UI MUST strictly use static dummy data for the initial implementation phase (no state management or backend integration needed yet).

### Key Entities 

- **Player Profile Layout**: A stateless structural definition dictating how avatar, stats row, and menu lists arrange themselves on the screen using provided core design widget standards.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All required visual components (App Bar, Avatar, Name/Email, 3 Stat Cards, 6 Menu Rows) are visible and visually match the specifications perfectly on a standard device.
- **SC-002**: The layout implements 100% of the UI constraints utilizing the predefined colors (e.g., AppColors) and styling systems without introducing custom hardcoded colors outside `AppColors` directives.

## Assumptions

- The initial implementation uses hardcoded static mock data; no real backend API call is expected for this specific task execution.
- Interactivity of menu items (e.g., clicking "Settings" to navigate) is not required for the immediate visual build, but the layout handles tap gestures if added later.
- Standard app fonts and existing core widgets (like `CustomBtn` or style files if needed) will be utilized for ensuring consistent appearance.