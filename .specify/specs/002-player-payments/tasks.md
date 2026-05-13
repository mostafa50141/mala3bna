---
description: "Task list for Player Payments Screen implementation"
---

# Tasks: Player Payments Screen

**Input**: Design documents from `/specs/002-player-payments/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Phase 1: User Story 1 - View Payment History (Priority: P1) 🎯 MVP

**Goal**: As a player, I want to view my payment history and summary so that I can track my spending and verify booking payments.

**Independent Test**: Can be fully tested by launching the app, navigating to the Profile tab, clicking the "Payments" menu item, and verifying the summary card and dummy list items render accurately.

### Implementation for User Story 1

- [x] T001 [P] [US1] Create PaymentModel
  - **File path**: `lib/features/player/payments/models/payment_model.dart`
  - **What it builds**: A Dart class `PaymentModel` representing payment transaction data.
  - **Acceptance check**: Class contains required fields (`id`, `courtName`, `courtImage`, `date`, `time`, `amount`, `status`) and compiles successfully.

- [x] T002 [P] [US1] Create Payments Summary Card Widget
  - **File path**: `lib/features/player/payments/views/widgets/payments_summary_card.dart`
  - **What it builds**: Reusable widget displaying total spent and total transaction counts.
  - **Acceptance check**: Renders a card (using `AppColors.colorBtnAndCard`) containing two statistic points (amount and count) styled using `Style`.

- [x] T003 [P] [US1] Create Payment Card Widget
  - **File path**: `lib/features/player/payments/views/widgets/payment_card.dart`
  - **What it builds**: Reusable widget for individual payment items.
  - **Acceptance check**: Renders court image, details, price, and a conditionally styled status badge ("Paid" in green, "Pending" in yellow).

- [x] T004 [US1] Create Payments Body Widget
  - **File path**: `lib/features/player/payments/views/widgets/payments_body.dart`
  - **What it builds**: The main content construct displaying `PaymentsSummaryCard` followed by a scrollable list of `PaymentCard` instances using static dummy data.
  - **Acceptance check**: Correctly instantiates dummy list items mapping to multiple `PaymentCard`s below the summary. *Depends on T001, T002, T003.*

- [x] T005 [US1] Create Payments View Screen
  - **File path**: `lib/features/player/payments/views/payments_view.dart`
  - **What it builds**: A `Scaffold` container providing the `AppBar` (with back arrow and "Payments" title) wrapping `PaymentsBody`.
  - **Acceptance check**: View constructs properly with the app bar over the newly built body section. *Depends on T004.*

- [x] T006 [US1] Integrate Navigation from Profile
  - **File path**: `lib/features/player/profile/views/widgets/profile_body.dart`
  - **What it builds**: Update the "Payments" `ProfileMenuItem`'s `onTap` property.
  - **Acceptance check**: Tapping "Payments" routes the user to `PaymentsView` via `Get.to(() => const PaymentsView())`. *Depends on T005.*

**Checkpoint**: At this point, the feature is fully functional as a static UI layout integrated into the app.
