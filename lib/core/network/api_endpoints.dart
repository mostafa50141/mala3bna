/// All paths are relative to the base URL:
/// https://graduation8project.pythonanywhere.com/api/v1/
class ApiEndpoints {
  ApiEndpoints._();

  // ─── Auth ──────────────────────────────────────────────────────────────────
  static const String login = 'auth/login/';
  static const String signup = 'auth/signup/';
  static const String requestOtp = 'auth/request-otp/';
  static const String resetPassword = 'auth/reset-password-otp/';
  static const String tokenRefresh = 'auth/token/refresh/';
  static const String changePassword = 'auth/change-password/';

  // ─── Fields (owner courts) ────────────────────────────────────────────────
  static const String fields = 'fields/';
  static String fieldDetail(String id) => 'fields/$id/';
  static String fieldToggleStatus(String id) => 'fields/$id/toggle-status/';

  // ─── Field Images ─────────────────────────────────────────────────────────
  static const String fieldImages = 'field_images/';
  static String fieldImageDetail(String id) => 'field_images/$id/';

  // ─── Bookings ─────────────────────────────────────────────────────────────
  static const String bookings = 'bookings/';
  static String bookingDetail(String id) => 'bookings/$id/';
  static String bookingAccept(String id) => 'bookings/$id/accept/';
  static String bookingDecline(String id) => 'bookings/$id/decline/';

  // ─── Owner Dashboard ──────────────────────────────────────────────────────
  static const String ownerDashboard = 'owner/dashboard/';

  // ─── Reviews ──────────────────────────────────────────────────────────────
  static const String reviews = 'reviews/';
  static String reviewDetail(String id) => 'reviews/$id/';

  // ─── Users ────────────────────────────────────────────────────────────────
  static const String users = 'users/';
  static String userDetail(String id) => 'users/$id/';
  static const String me = 'users/me/';
  static const String deleteAccount = 'users/me/delete-account/';
}
