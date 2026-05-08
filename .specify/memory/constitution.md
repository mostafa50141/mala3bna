<!--
Sync Impact Report:
- Version change: 1.0.0 (initial)
- Modified principles:
  - Clean Architecture & Feature-First
  - State Management (Cubit Only)
  - Dependency Injection & Navigation
  - Error Handling & Networking
  - Storage & UI Guidelines
- Added sections:
  - Application Roles
  - Technology Stack & Constants
- Removed sections: N/A
- Templates requiring updates (✅ updated / ⚠ pending): ✅ None pending.
- Follow-up TODOs: Implement missing player profile screen, coach screens, and real API integration.
-->
# mala3bna Constitution

## Core Principles

### I. Clean Architecture & Feature-First
The app follows Clean Architecture (Data → Domain → Presentation) and uses a feature-first folder structure. Each feature contains its own data (models, repos) and presentation (views, views_model/cubit) layers. 

### II. State Management (Cubit Only)
Use `flutter_bloc` for state management, specifically Cubit. Never use full Bloc. States must be sealed classes containing Initial, Loading, Success, Failure. BlocProvider must be used at the screen level only. No `setState` except for purely local UI state.

### III. Dependency Injection & Navigation
Use `get_it` for dependency injection (register abstract types only). All repos must be registered in `setupServiceLocator()`. For navigation, use `get` (`Get.to`, `Get.offAll`, `Get.back` only) — no GoRouter.

### IV. Error Handling & Networking
Use `dartz` (`Either<Failure, T>`) for error handling with specific Failure classes (e.g., `ServerFailure`). Use `dio` with an `ApiService` wrapper for HTTP calls. Inject auth tokens via Dio interceptor. Base URL: `https://bqsl6hrg-8000.uks1.devtunnels.ms/api/v1/`.

### V. Storage & UI Guidelines
Use `flutter_secure_storage` via `LocalStorageHelper` for JWT token storage, and `get_storage` for role persistence. Adhere to the app's predefined colors (primary teal: `Color.fromARGB(255, 46, 159, 129)`, dark green background: `Color.fromARGB(255, 15, 45, 49)`, dark card color: `Color(0xFF1A1D24)`). Use `getResponsiveFontSize()` for responsive font sizes. Never hardcode strings.

## Application Roles

- **player**: Books courts, views coaches, manages bookings.
- **owner**: Manages courts, handles booking requests.
- **coach**: Manages sessions, schedule, earnings.

## Technology Stack & Constants

**UI Packages**: `cached_network_image`, `lottie`, `fl_chart`, `carousel_slider`.
**Constants & Utils**: Located in `lib/core/` (e.g., `app_colors.dart`, `utils/api_server.dart`, `utils/service_locator.dart`).
**Current Status**: 
- Auth: Done (login, signup, splash, welcome) - fake API, needs real API wiring.
- Player: Home UI done, courts booking UI done, profile screen MISSING.
- Owner: Dashboard done, booking requests done, settings done.
- Coach: All screens are empty placeholders.

## Governance

Amendments require documentation, approval, and compliance review. All PRs and code reviews must verify adherence to Clean Architecture, Cubit-only state management, and the feature-first structure.

**Version**: 1.0.0 | **Ratified**: 2026-05-08 | **Last Amended**: 2026-05-08
