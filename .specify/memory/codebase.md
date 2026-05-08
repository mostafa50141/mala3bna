# mala3bna — Codebase Reference

## 1. Full Folder Structure (lib/)

```
lib/
├── main.dart
├── core/
│   ├── constants/
│   │   └── app_colors.dart
│   ├── errors/
│   │   └── failure.dart
│   ├── navigation/
│   │   ├── player_main_navigation.dart
│   │   ├── owner_main_navigation.dart
│   │   └── coach_main_navigation.dart
│   ├── role/
│   │   ├── app_root.dart
│   │   └── user_role.dart
│   ├── utils/
│   │   ├── api_server.dart
│   │   ├── assets_data.dart
│   │   ├── local_storage_helper.dart
│   │   ├── service_locator.dart
│   │   └── style.dart
│   └── widgets/
│       ├── custom_animateds_snack_bar.dart
│       ├── custom_bottom_nav.dart
│       ├── custom_btn.dart
│       ├── custom_text.dart
│       ├── custome_circular_avatar.dart
│       ├── custome_circular_laoding.dart
│       ├── custome_erorr_widget.dart
│       ├── custome_gradiant.dart
│       ├── custome_text_field.dart
│       └── section_title.dart
├── features/
│   ├── splash/
│   │   └── presentation/views/
│   │       ├── splash_screen.dart
│   │       └── widgets/
│   │           ├── sliding_text.dart
│   │           └── splash_screen_body.dart
│   ├── Splash_Screen/  (legacy/empty)
│   │   ├── data/
│   │   └── presentation/views_model/
│   ├── welcome_screen/
│   │   └── presentation/views/
│   │       ├── welcome_screen.dart
│   │       └── widgets/welcome_screen_body.dart
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/usermodel.dart
│   │   │   └── Repos/
│   │   │       ├── auth_repo.dart (abstract)
│   │   │       └── auth_repo_imp.dart
│   │   └── presentation/
│   │       ├── data/auth_controller.dart (GetX)
│   │       ├── views/
│   │       │   ├── login_screen.dart
│   │       │   ├── sign_up_screen.dart
│   │       │   ├── forget_password_screen.dart
│   │       │   └── widgets/
│   │       │       ├── login_screen_body.dart
│   │       │       ├── sign_up_body.dart
│   │       │       ├── forget_password_body.dart
│   │       │       ├── contuie_with.dart
│   │       │       ├── custome_Choice_Chip.dart
│   │       │       ├── custome_toggle_tab.dart
│   │       │       ├── navigate_to_term.dart
│   │       │       └── password_text_field.dart
│   │       └── views_model/cubit/
│   │           ├── auth_cubit.dart
│   │           └── auth_state.dart
│   ├── home/ (empty data/presentation stubs)
│   ├── courts_booking/ (empty data/repos/models stubs)
│   ├── profile/ (legacy, contains views/profile_view.dart)
│   ├── player/
│   │   ├── home/presentation/views/
│   │   │   ├── home_view.dart
│   │   │   └── widgets/
│   │   │       ├── Academics_category.dart
│   │   │       ├── coach_category.dart
│   │   │       ├── courts_category.dart
│   │   │       ├── games_category.dart
│   │   │       ├── home_view_body.dart
│   │   │       ├── list-view-of-coach-category.dart
│   │   │       ├── list_view-of-courts-category.dart
│   │   │       ├── list_view_of_academic_category.dart
│   │   │       ├── search_field.dart
│   │   │       ├── user_info_home_screen.dart
│   │   │       └── user_info_search_field_container.dart
│   │   ├── courts_booking/views/
│   │   │   ├── confirmed_booking_page.dart
│   │   │   ├── court_booking_summry.dart
│   │   │   ├── court_details.dart  (BookingsView class)
│   │   │   └── widgets/ (14 widget files)
│   │   ├── messages/views/messages_view.dart (placeholder)
│   │   └── profile/
│   │       ├── models/my_booking_court_card_model.dart
│   │       ├── model_view/ (empty)
│   │       └── views/
│   │           ├── profile_view.dart (redirects to MyBookingsViews)
│   │           ├── my_bookings_views.dart
│   │           └── widgets/
│   │               ├── court_card_image.dart
│   │               ├── court_card_list_view.dart
│   │               ├── custome_app_bar.dart
│   │               ├── custome_court_card.dart
│   │               ├── custome_tab_bar.dart
│   │               └── my_booking_body.dart
│   ├── owner/
│   │   ├── ownerDashboard/presentation/
│   │   │   ├── data/amenity_of_add_court.dart
│   │   │   └── view/
│   │   │       ├── add_court_view.dart
│   │   │       ├── owner_dashboard_view.dart
│   │   │       └── widgets/ (13 widget files)
│   │   ├── booking/presentation/
│   │   │   ├── model/booking_request_model.dart
│   │   │   └── view/
│   │   │       ├── booking_request_view.dart
│   │   │       └── widgets/ (5 widget files)
│   │   ├── courts/presentation/view/my_court_view.dart (placeholder)
│   │   └── setting/presentation/view/
│   │       ├── owner_settings_view.dart
│   │       └── widgets/ (12 widget files)
│   └── coach/
│       ├── coachDashboard/presentation/view/coach_dashboard_view.dart (placeholder)
│       ├── schedule/presentation/views/coach_schedule_view.dart (placeholder)
│       ├── messages/presentation/views/coach_messages_view.dart (placeholder)
│       └── profile/presentation/views/coach_profile_view.dart (placeholder)
├── generated/ (l10n auto-generated)
└── l10n/intl_en.arb
```

## 2. Packages (pubspec.yaml)

| Package | Version | Purpose |
|---------|---------|---------|
| animated_snack_bar | ^0.4.0 | Animated snackbar notifications |
| badges | ^3.1.2 | Badge overlays on bottom nav icons |
| bloc | ^9.2.0 | BLoC core |
| cached_network_image | ^3.4.1 | Cached network images |
| carousel_slider | ^5.1.1 | Image carousels |
| cupertino_icons | ^1.0.8 | iOS-style icons |
| dartz | ^0.10.1 | Either/functional error handling |
| dio | ^5.9.2 | HTTP client |
| fl_chart | ^1.1.1 | Charts (revenue, stats) |
| flutter_bloc | ^9.1.1 | BlocProvider/BlocBuilder |
| flutter_launcher_icons | ^0.14.4 | App icon generation |
| flutter_secure_storage | ^10.0.0 | JWT token storage |
| flutter_svg | ^2.2.3 | SVG rendering |
| font_awesome_flutter | ^10.12.0 | FontAwesome icons |
| gap | ^3.0.1 | Spacing widget |
| get | ^4.7.2 | Navigation + AuthController |
| get_it | ^9.2.0 | Dependency injection |
| get_storage | ^2.1.1 | Role persistence |
| go_router | ^17.1.0 | Listed but NOT used |
| google_fonts | ^6.3.2 | Inter font |
| image_picker | ^1.2.1 | Image selection |
| intl | ^0.20.2 | Localization |
| lottie | ^3.3.2 | Lottie animations |
| meta | ^1.16.0 | @immutable annotations |
| multi_image_picker_view | ^3.0.0 | Multi-image picker |
| qr_flutter | ^4.1.0 | QR code generation |
| smooth_page_indicator | ^2.0.1 | Page indicators |
| table_calendar | ^3.2.0 | Calendar widget |

**SDK**: `^3.9.0` | **Font**: Inter (bundled in assets/fonts/)

## 3. Architecture Pattern

**Clean Architecture (Data → Domain → Presentation)** with **feature-first** folders.

Each feature follows:
```
feature/
  data/
    models/        ← Data models with fromJson/toJson
    repos/
      feature_repo.dart       ← Abstract class
      feature_repo_impl.dart  ← Concrete implementation
  presentation/
    views/
      feature_view.dart       ← Screen (wraps BlocProvider)
      widgets/                ← Extracted UI widgets
    views_model/
      cubit/
        feature_cubit.dart
        feature_state.dart
```

**Note**: No separate `domain/` layer exists. Abstract repos in `data/repos/` serve as the domain contract.

## 4. State Management Pattern

**Cubit only** (never full Bloc). States use `sealed class`:

```dart
// auth_state.dart
part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}
final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthSuccess extends AuthState {
  final Usermodel user;
  AuthSuccess({required this.user});
}
final class AuthFailure extends AuthState {
  final String errorMessage;
  AuthFailure(this.errorMessage);
}
```

**Cubit pattern**:
```dart
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;

  Future<void> login({...}) async {
    emit(AuthLoading());
    var result = await authRepo.login(...);
    result.fold(
      (failure) => emit(AuthFailure(failure.errmessage ?? "...")),
      (user) => emit(AuthSuccess(user: user)),
    );
  }
}
```

**BlocProvider at screen level**:
```dart
class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocProvider(
      child: const LoginScreenBody(),
      create: (context) => AuthCubit(getIt.get<AuthRepo>()),
    );
  }
}
```

**Role controller** uses GetX (`AuthController extends GetxController`) for reactive role-based routing via `Obx`.

## 5. Navigation Pattern

**GetMaterialApp** is the root. Uses `get` package navigation:
- `Get.to(() => Screen())` — push
- `Get.offAll(() => Screen())` — replace all
- `Get.back()` — pop

**Role-based routing** via `AppRoot`:
```dart
class AppRoot extends StatelessWidget {
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Obx(() {
      final role = authController.userRole.value;
      if (role == null) return const LoginScreen();
      switch (role) {
        case UserRole.player: return const PlayerMainNavigation();
        case UserRole.owner:  return const OwnerMainNavigation();
        case UserRole.coach:  return const CoachMainNavigation();
      }
    });
  }
}
```

**Bottom navigation** uses `IndexedStack` + `CustomBottomNav` per role:
- **Player**: Home, Courts, Messages, Profile (4 tabs)
- **Owner**: Dashboard, Booking, Courts, Profile (4 tabs)
- **Coach**: Dashboard, Schedule, Messages, Profile (4 tabs)

**Flow**: `SplashScreen → WelcomeScreen → LoginScreen → AppRoot → RoleNavigation`

## 6. DI Pattern (service_locator.dart)

```dart
final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(dio: Dio()));
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImp(apiService: getIt.get<ApiService>()),
  );
  getIt.registerSingleton<LocalStorageHelper>(LocalStorageHelper());
}
```

Called in `main()` before `runApp()`. Registers abstract types, resolves concrete implementations.

## 7. Error Handling Pattern

**Base class**: `Failure` (abstract, has `errmessage` field)
**Concrete**: `ServerFailure` with two factories:
- `ServerFailure.fromDioError(DioException)` — maps DioExceptionType
- `ServerFailure.fromResponse(statusCode, response)` — maps HTTP status codes (400, 401, 403, 404, 409, 500)

**Usage**: Repos return `Future<Either<Failure, T>>` via `dartz`. Cubits fold the result:
```dart
result.fold(
  (failure) => emit(AuthFailure(failure.errmessage ?? "Something went wrong")),
  (user) => emit(AuthSuccess(user: user)),
);
```

## 8. Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Files | snake_case | `auth_cubit.dart`, `home_view.dart` |
| Classes | PascalCase | `AuthCubit`, `HomeView` |
| Cubits | `FeatureCubit` | `AuthCubit` |
| States | `FeatureState` (sealed) | `AuthState`, `AuthLoading` |
| Views | `FeatureView` | `HomeView`, `ProfileView` |
| Repos (abstract) | `FeatureRepo` | `AuthRepo` |
| Repos (impl) | `FeatureRepoImp` | `AuthRepoImp` |
| Models | `Featuremodel` | `Usermodel` |
| Widgets | `CustomeXxx` or `CustomXxx` | `CustomBtn`, `CustomeTabBar` |
| Navigation | `RoleMainNavigation` | `PlayerMainNavigation` |

**Note**: Inconsistent spelling — `custom` vs `custome`, `laoding` vs `loading`, `erorr` vs `error`.

## 9. Color System (AppColors)

```dart
class AppColors {
  static Color primaryColor = Color.fromARGB(255, 46, 159, 129);    // teal
  static Color backgroundColor = Color.fromARGB(255, 15, 45, 49);   // dark green
  static Color colorBtnAndCard = const Color(0xFF1A1D24);            // dark card
  static Color fieldBackground = Color(0xFF60704D);                  // olive field
  static Color textFieldHint = Colors.white54;
  static Color leftGradient = Color.fromARGB(177, 11, 28, 16);      // dark gradient
  static Color rightGradient = colorBtnAndCard;                      // matches card
}
```

Additional hardcoded colors found in widgets:
- `Color(0xFF39E079)` — green avatar ring (custome_circular_avatar.dart)
- `Color(0xFF52C77A)` — text field focused border (custome_text_field.dart)
- `Color(0xFF0A3A2A)` / `Color(0xFF051810)` — gradient background widget

## 10. Existing Features by Role

### Auth (shared)
| Screen | Status | Notes |
|--------|--------|-------|
| SplashScreen | ✅ Done | Animated logo + sliding text |
| WelcomeScreen | ✅ Done | Background image + CTA buttons |
| LoginScreen | ✅ Done | BlocProvider wraps LoginScreenBody |
| SignUpScreen | ✅ Done | BlocProvider wraps SignUpBody |
| ForgetPasswordScreen | ✅ Done | UI only |
| AuthCubit | ✅ Done | login/signUp/logout methods |
| AuthRepo | ✅ Done | Abstract + impl with real API endpoints |
| AuthController | ✅ Done | GetX controller for role persistence |

**API currently points to `https://fakestoreapi.com/`** (real URL commented out).

### Player
| Screen | Status | Notes |
|--------|--------|-------|
| HomeView | ✅ Done | Categories, coaches, courts, search |
| Courts Booking (list) | ✅ Done | CourtDetailsBody with carousel, calendar, time slots |
| Court Booking Summary | ✅ Done | Summary card, payment, QR |
| Confirmed Booking | ✅ Done | Confirmation page |
| ProfileView | ⚠️ Incomplete | Redirects directly to MyBookingsViews (no profile screen) |
| MyBookingsViews | ✅ Done | Has TabBar (Upcoming/Past/Cancelled) |
| MessagesView | ❌ Placeholder | Just shows "Messages screen" text |

### Owner
| Screen | Status | Notes |
|--------|--------|-------|
| OwnerDashboardView | ✅ Done | AppBar + stats grid + revenue chart + add court |
| AddCourtView | ✅ Done | Multi-step form with amenities, images, pricing |
| BookingRequestView | ✅ Done | Filter chips + booking cards |
| MyCourtView | ❌ Placeholder | Just shows "My Courts View" text |
| OwnerSettingsView | ✅ Done | Full settings with profile header, toggles, language/theme sheets |

### Coach
| Screen | Status | Notes |
|--------|--------|-------|
| CoachDashboardView | ❌ Placeholder | `Text("Coach Dashboard")` |
| CoachScheduleView | ❌ Placeholder | `Text("Coach Schedule")` |
| CoachMessagesView | ❌ Placeholder | `Text("Coach Messages")` |
| CoachProfileView | ❌ Placeholder | `Text("Coach Profile")` |

## 11. What Is Missing or Incomplete

### Critical Missing
1. **Player Profile Screen** — `ProfileView` skips straight to `MyBookingsViews`. No avatar, name, stats, or menu.
2. **All Coach Screens** — Dashboard, Schedule, Messages, Profile are all single-line placeholders.
3. **Real API Integration** — `ApiService._baseUrl` points to `fakestoreapi.com`. Real URL is commented out.
4. **Dio Interceptor** — No token injection interceptor exists. Token is saved but never attached to requests.
5. **Token Refresh** — No refresh/expiry handling.

### Incomplete Features
6. **Player Messages** — Placeholder text only.
7. **Owner My Courts** — Placeholder text only.
8. **Player Payments Screen** — Does not exist.
9. **Court Search/Filter** — No sport-type filter or name/location search on courts listing.
10. **Coach Earnings Screen** — Does not exist.
11. **Coach Sessions Screen** — Does not exist.
12. **Coach Settings Screen** — Does not exist.

### Structural Issues
13. **Legacy folders** — `features/Splash_Screen/`, `features/home/`, `features/courts_booking/`, `features/profile/` are empty/stubs alongside the real implementations under `features/player/` and `features/splash/`.
14. **go_router in pubspec** — Listed as dependency but never used (navigation uses `get`).
15. **Hardcoded colors** — Some widgets use inline color values instead of `AppColors`.
16. **Inconsistent naming** — `custome` vs `custom`, `laoding` vs `loading`, `Repos` (capital R folder).

## 12. Shared Widgets (lib/core/widgets/)

| Widget | File | Description | Key Props |
|--------|------|-------------|-----------|
| `CustomBtn` | custom_btn.dart | Tappable container button | text, icon, height, width, radius, color, border |
| `customText` | custom_text.dart | Styled Text widget (lowercase class name) | text, color, size, weight, overflow, maxLines, textAlign |
| `CustomTextfield` | custome_text_field.dart | TextFormField with rounded borders | hintText, obscureText, onChanged, validator, controller, suffixIcon, fillcolor |
| `CustomBottomNav` | custom_bottom_nav.dart | Bottom nav with badge support + rounded top corners | currentIndex, onTap, items, badges |
| `CustomeCirculerAvtar` | custome_circular_avatar.dart | CircleAvatar radius 45, green ring | backgroundImage |
| `CustomeCircularLaoding` | custome_circular_laoding.dart | Animated dual-ring loading spinner | (none) |
| `CustomeErorrWidget` | custome_erorr_widget.dart | Red centered Arabic error text "حدث خطأ ما" | (none) |
| `GradientBackground` | custome_gradiant.dart | Dark green vertical gradient container | child |
| `showAnimatedSnackDialog` | custom_animateds_snack_bar.dart | Function: shows AnimatedSnackBar | context, message, type |
| `SectionTitle` | section_title.dart | Bold 20px section heading | title |

## Style Utilities (lib/core/utils/style.dart)

`Style` abstract class provides pre-built `TextStyle` constants using `getResponsiveFontSize()`:
- `textStyle35Bold`, `textStyle30Bold`, `textStyleBold26`, `textStyle26`
- `textStyle20`, `textStyle20Bold`, `textStyle18`, `textStyle18Bold`
- `textStyle16`, `textStyle16Bold`, `textStyle14`, `textStyle14Bold`
- `textStyle12`, `textStyle12Bold`

`getResponsiveFontSize()` clamps between 0.8x–1.2x based on screen width breakpoints (800/1300).

## Assets

```
assets/
├── images/
│   ├── mala3bna-splashscreen-logo.png
│   ├── mala3bna-splashscreen-background.png
│   ├── back.jpeg
│   ├── Logo.png
│   ├── Padel court at night.png
│   ├── Football court.png
│   ├── football_icon.svg
│   ├── padel_icon.svg
│   └── app_logo.png
├── fonts/Inter-Regular.otf
└── animations/ (directory registered, contents unknown)
```

## App Entry Point (main.dart)

```dart
void main() async {
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(AuthController());
  runApp(const MyApp());
}
```

Uses `GetMaterialApp` with locale `eg`, dark theme, Inter font, `AppColors.backgroundColor` scaffold, starts at `SplashScreen`.
