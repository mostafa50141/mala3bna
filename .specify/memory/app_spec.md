# Feature Specification: mala3bna Full App Implementation

**Feature Branch**: `mala3bna-app-implementation`  
**Created**: 2026-05-08  
**Status**: Draft  
**Input**: User description regarding missing Player features, Coach features, Auth API wiring, and Court search/filter capabilities.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Authentication API Integration (Priority: P1)

Users must be able to securely authenticate using real API endpoints and maintain their session via JWT tokens.

**Why this priority**: Without authentication, users cannot access role-specific functionality (Player, Coach, Owner).

**Independent Test**: Can be fully tested by verifying that login/signup requests reach the server, a token is returned, stored securely, and subsequent requests include the token in headers.

**Acceptance Scenarios**:

1. **Given** a user is on the login screen, **When** they submit valid credentials, **Then** they receive a token, the token is saved via `flutter_secure_storage`, and they are navigated to their role's home screen.
2. **Given** an authenticated user makes an API request, **When** the Dio interceptor processes the request, **Then** the Authorization header is injected with the JWT token.
3. **Given** an expired token, **When** a request fails with 401, **Then** the app attempts to refresh the token or prompts the user to log in again.

---

### User Story 2 - Player Profile & Management (Priority: P1)

Players need a comprehensive profile screen to view their stats and manage their bookings.

**Why this priority**: Completes the core player experience by providing visibility into their activity and account settings.

**Independent Test**: Can be tested independently using dummy data models conforming to Clean Architecture.

**Acceptance Scenarios**:

1. **Given** a logged-in player, **When** they navigate to their profile, **Then** they see their avatar, name, email, and a stats row (total bookings, favorite sport, member since).
2. **Given** a player on the My Bookings screen, **When** they interact with the TabBar, **Then** they can switch between Upcoming, Past, and Cancelled bookings.
3. **Given** a player on the Payments screen, **When** they view the history, **Then** they see a list of payments with court name, date, amount, and status.

---

### User Story 3 - Coach Experience (Priority: P1)

Coaches require a dedicated suite of screens to manage their schedule, sessions, and earnings.

**Why this priority**: The Coach role currently consists of empty placeholders. Providing the UI and Cubits is essential for a functional app.

**Independent Test**: Can be tested independently by navigating through the Coach bottom navigation and verifying static dummy data renders correctly.

**Acceptance Scenarios**:

1. **Given** a logged-in coach, **When** they view the Dashboard, **Then** they see total sessions, weekly earnings, rating, and upcoming sessions.
2. **Given** a coach views their Schedule, **When** the calendar is displayed, **Then** they see a weekly view with a list of sessions per day (player name, sport, time, court).
3. **Given** a coach views the Earnings screen, **When** the screen loads, **Then** they see a weekly revenue chart and earnings history.

---

### User Story 4 - Court Search & Filtering (Priority: P2)

Players must be able to easily find relevant courts for their preferred sport and location.

**Why this priority**: Enhances the player booking experience by allowing them to discover courts efficiently.

**Independent Test**: Can be tested by applying filters and verifying the list updates accordingly using dummy data.

**Acceptance Scenarios**:

1. **Given** a player is on the Courts screen, **When** they filter by "Football" or "Padel", **Then** the list updates to show only matching courts.
2. **Given** a player uses the search bar, **When** they type a court name or location, **Then** the list updates to display matching results.

---

### User Story 5 - Coach & Player Messaging (Priority: P3)

Users need a way to communicate regarding upcoming sessions or bookings.

**Why this priority**: Important for engagement, but secondary to core booking and management flows.

**Independent Test**: Can be tested by navigating to the messages list and viewing simulated chat threads.

**Acceptance Scenarios**:

1. **Given** a coach or player is on the Messages screen, **When** the list loads, **Then** they see active chats with the other party's avatar, name, last message, and unread badge.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST connect `auth/login` and `auth/signup` features to the real API endpoint `https://bqsl6hrg-8000.uks1.devtunnels.ms/api/v1/`.
- **FR-002**: System MUST inject JWT tokens into all authenticated API calls using a Dio interceptor.
- **FR-003**: System MUST implement the Player Profile screen with avatar, name, stats row, and a menu list of items featuring a circular green icon and chevron.
- **FR-004**: System MUST update the Player My Bookings screen to use a TabBar separating Upcoming, Past, and Cancelled bookings.
- **FR-005**: System MUST implement the Player Payments screen displaying a list of transaction history.
- **FR-006**: System MUST implement the full suite of Coach screens (Dashboard, Profile, Schedule, Earnings, Sessions, Messages, Settings).
- **FR-007**: System MUST allow players to search courts by name or location and filter them by sport type.
- **FR-008**: System MUST utilize `flutter_bloc` (Cubit only) with sealed states (Initial, Loading, Success, Failure) for all new screens.
- **FR-009**: System MUST initialize all new features with static dummy data before wiring to real APIs (except Auth which requires immediate wiring).

### Key Entities

- **User (Player/Coach)**: ID, name, email, role, avatar, stats (bookings/sessions, favorite sport/specialty).
- **Court**: ID, name, location, sport_type (football/padel), image_url.
- **Booking/Session**: ID, court_id, player_id, coach_id (optional), datetime, status, amount.
- **Payment**: ID, booking_id, amount, date, status (paid/pending).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Auth integration correctly handles token acquisition, storage, and injection without exposing credentials.
- **SC-002**: All specified Player screens are fully implemented and navigable without crashes.
- **SC-003**: All placeholder Coach screens are replaced with functional UIs rendering static dummy data correctly.
- **SC-004**: The app adheres strictly to Clean Architecture principles, avoiding any direct Data layer calls from the Presentation layer, routing all logic through Repositories and Cubits.
- **SC-005**: The UI consistently uses the predefined `AppColors` and responsive font utilities, avoiding hardcoded values.

## Assumptions

- The provided Dev Tunnels API Base URL is intermittent, so robust error handling (using `dartz` `ServerFailure`) is required to handle timeouts and unavailable endpoints gracefully.
- The UI for Coach charts can be sufficiently built using the `fl_chart` package.
- All routing will be handled via the existing `get` package navigation methods (`Get.to`, `Get.back`, etc.).
