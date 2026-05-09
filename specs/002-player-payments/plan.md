# Implementation Plan: Player Payments Screen

**Branch**: `002-player-payments` | **Date**: May 9, 2026 | **Spec**: [specs/002-player-payments/spec.md](specs/002-player-payments/spec.md)
**Input**: Feature specification from `/specs/002-player-payments/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Build a stateless static screen (Player Payments) mimicking historical transactions and total expenditures. The implementation requires isolated widget components, a specific static data model matching domain logic, and a routed transition point from the existing Profile view layout.

## Technical Context

**Language/Version**: Dart, Flutter SDK (`^3.9.0`)
**Primary Dependencies**: `get` for navigation mapping, `AppColors` predefined themes
**Storage**: N/A
**Testing**: Opt-out
**Target Platform**: Android/iOS
**Project Type**: Mobile Application
**Performance Goals**: N/A
**Constraints**: Follow clean architecture structure precisely under `lib/features/player/payments/`. Do NOT write state management elements like Cubit. Avoid utilizing network APIs. Reconstruct design parameters explicitly.
**Scale/Scope**: 5 required files 

## Target Files

```text
lib/
└── features/
    └── player/
        └── payments/
            ├── models/
            │   └── payment_model.dart (Data representation of payment item)
            └── views/
                ├── payments_view.dart (Top scaffold wrapper, appbar, integrates body)
                └── widgets/
                    ├── payments_body.dart (Construct item collections and mapping iterators)
                    ├── payment_card.dart (Individual container format representation)
                    └── payments_summary_card.dart (Aggregated total cost stat card snippet)
```

## Details & Logic

- **Navigation Integration**: Update the Payments label handler located in `lib/features/player/profile/views/widgets/profile_body.dart` calling `Get.to(() => const PaymentsView())`. 
- **Dependencies**: Relies completely on existing `AppColors` mappings like `AppColors.backgroundColor`, `AppColors.colorBtnAndCard`, `AppColors.primaryColor` plus global `Color(0XFFEAB308)` hex reference representing purely yellow status tokens.
- **Model Formatter**: `payment_model.dart` exposes `{id, courtName, courtImage, date, time, amount, status}` properties securely.

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
