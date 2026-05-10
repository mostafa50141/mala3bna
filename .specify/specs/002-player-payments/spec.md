# Feature Specification: Player Payments Screen

**Feature Branch**: `002-player-payments`  
**Created**: May 9, 2026  
**Status**: Draft  
**Input**: User description: "Feature: Player Payments Screen. Required UI: - AppBar: back arrow + "Payments" title - Summary card at top..."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - View Payment History (Priority: P1)

As a player, I want to view my payment history and summary so that I can track my spending and verify booking payments.

**Why this priority**: It is essential for users to access billing records for transparency and trust before enabling real transactions.

**Independent Test**: Can be fully tested by launching the app, navigating to the Profile tab, clicking the "Payments" menu item, and verifying the summary card and dummy list items render accurately.

**Acceptance Scenarios**:

1. **Given** I am on the Profile screen, **When** I tap "Payments", **Then** I am navigated to the Payments screen with a back arrow and "Payments" title.
2. **Given** I am on the Payments screen, **When** I view the top section, **Then** I see a summary card displaying the total amount spent and the number of transactions.
3. **Given** I am on the Payments screen, **When** I scroll through the list, **Then** I see payment history items, each containing a court image, name, date, time, and the amount in EGP.
4. **Given** a payment item is rendered, **When** I look at its status, **Then** it properly displays a "Paid" badge in green or a "Pending" badge in yellow.

---

### Edge Cases

- What happens if the user has no payment history? (A placeholder empty state or just an empty list beneath the summary).
- How is text handled if the court name is very long? (It should be truncated to prevent UI overflow).

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST provide navigation from the "Payments" menu item in the existing `ProfileView` to the `PaymentsView`.
- **FR-002**: The `PaymentsView` MUST have an AppBar with a functional back arrow and a "Payments" title.
- **FR-003**: The screen MUST display a top summary card reporting static dummy totals for "Amount Spent" and "Transactions".
- **FR-004**: The screen MUST render a scrollable list of payment history cards.
- **FR-005**: Each payment item card MUST render a small rounded court image, court name, date, time, and transaction amount in EGP.
- **FR-006**: Each payment item card MUST display a visual status badge ("Paid" using `AppColors.primaryColor` or "Pending" using `Color(0XFFEAB308)`).
- **FR-007**: The UI MUST be implemented exclusively with static mock data without real API ingestion for this phase.
- **FR-008**: The implementation MUST strictly use colors defined in `AppColors` and typography from `Style`.

### Key Entities

- **PaymentItem**: Data structure defining the static mock data (Court Name, Image URL, Date, Time, Amount, and Status).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: The Payments screen completely matches the provided required UI list requirements without missing any piece (Summary card + list items + badges).
- **SC-002**: The transition from ProfileView to PaymentsView occurs seamlessly using Get/Navigator when the "Payments" option is tapped.
- **SC-003**: No new custom colors are introduced except the required `Color(0XFFEAB308)` for the pending status and existing ones from `AppColors`.

## Assumptions

- Interactive features like payment disputes or downloading receipts are out of scope.
- Hardcoded dummy data is sufficient for initial presentation and structural validation.
- Existing core widgets and utility constants (like `AppColors.colorBtnAndCard`) are available and functionally complete.