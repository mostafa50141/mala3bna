# Research & Decisions: Player Payments Screen

## Static Dummy Data

- **Decision**: Define a local `PaymentModel` directly in the feature folder to hold static properties (id, courtName, courtImage, date, time, amount, status).
- **Rationale**: Since the prompt restricts to "Static dummy data only (no cubit yet)", we encapsulate all static definitions within internal data classes to isolate functionality while meeting criteria.

## Navigation Setup

- **Decision**: Update `ProfileMenuItem` inside `lib/features/player/profile/views/widgets/profile_body.dart` corresponding to Payments. The `onTap` property will trigger `Get.to(() => const PaymentsView())`. 
- **Rationale**: The target application explicitly utilizes GetX for routing according to previously analyzed features (e.g. `core/role/app_root.dart` using `GetX`).

## Widget Component Extraction

- **Decision**: Break down the screen into modular standard feature implementations conforming to codebase specifications: `PaymentsSummaryCard` at the top, a `PaymentCard` specifically handling styling conditions based on Status property, and merging them inside `PaymentsBody`. 
- **Rationale**: Encourages strict Clean Architecture separation of responsibilities inside the feature module.
