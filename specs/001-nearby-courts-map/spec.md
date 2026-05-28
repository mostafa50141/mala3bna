# Feature Specification: Nearby Courts Map

**Feature Branch**: `[###-nearby-courts-map]`  
**Created**: May 28, 2026  
**Status**: Draft  

## User Scenarios & Testing *(mandatory)*

### User Story 1 - View Nearby Courts Map (Priority: P1)

As a player, I want to see a map on the home screen showing my current location and nearby courts, so that I can easily discover venues near me.

**Why this priority**: Core value of a map feature is discovery based on proximity, heavily improving user engagement and booking likelihood.

**Independent Test**: Can be independently tested by opening the app, granting location permission, and verifying the map renders with a user location marker and court markers.

**Acceptance Scenarios**:

1. **Given** the app has location permissions, **When** the home screen loads, **Then** a map section titled "Courts Near You" is displayed showing my location as a blue circle and courts as teal circles.
2. **Given** the app does not have location permissions, **When** the home screen loads, **Then** the map container displays a message "Enable location to see nearby courts".
3. **Given** the map is loading location data, **When** the home screen is first opened, **Then** a circular loading indicator is displayed.

---

### User Story 2 - Navigate to Court Booking (Priority: P2)

As a player, I want to tap on a court marker on the map so that I can directly view its details and make a booking.

**Why this priority**: Direct conversion path from discovery to booking.

**Independent Test**: Can be tested by tapping a marker and ensuring the app navigates to the booking flow for the selected court.

**Acceptance Scenarios**:

1. **Given** the map is loaded with court markers, **When** I tap a teal court marker, **Then** I am navigated to the Booking view for that specific court.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST display a map section titled "Courts Near You" on the Player Home Screen.
- **FR-002**: System MUST request location permissions to determine the user's current location.
- **FR-003**: System MUST display the user's current location on the map with a distinctive blue marker.
- **FR-004**: System MUST display hardcoded courts as markers on the map using a distinctive teal indicator.
- **FR-005**: System MUST navigate the user to the court booking view when a court marker is tapped.
- **FR-006**: System MUST handle the loading state by displaying a circular loader while retrieving location data.
- **FR-007**: System MUST handle denied location permissions by displaying a fallback message.

### Key Entities

- **Court**: Needs geographic coordinates (latitude and longitude) to be plotted on the map.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Users can grant location permission and see the map load within 3 seconds on a standard network connection.
- **SC-002**: Tapping a court marker successfully transitions to the booking page with 100% accuracy.
- **SC-003**: At least 30% of user sessions interact with the map feature for discovery.

## Assumptions

- Users have basic internet connectivity to load map tiles.
- The free OpenStreetMap tile service will provide adequate uptime and performance.
- Hardcoded coordinates will temporarily replace geographic data fetched from a backend.
- Fallback coordinates (Cairo) will be used initially for rendering if real-time positioning encounters delays or if permission is denied.