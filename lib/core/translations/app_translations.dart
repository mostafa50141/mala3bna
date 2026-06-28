import 'package:get/get.dart';

/// Full app translations — English & Arabic.
///
/// Keys are the English strings. Arabic values are the translations.
/// Use [key.tr] in any widget to get the translated string automatically.
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': _en,
        'ar': _ar,
      };
}

// ─── English ────────────────────────────────────────────────────────────────────

const Map<String, String> _en = {
  // ── Settings ─────────────────────────────────────────────────────────────────
  'Profile & Settings': 'Profile & Settings',
  'Manage your account': 'Manage your account',
  'Log Out': 'Log Out',
  'Cancel': 'Cancel',
  'Are you sure you want to log out\nof your account?':
      'Are you sure you want to log out\nof your account?',
  'Push Notifications': 'Push Notifications',
  'Enabled': 'Enabled',
  'Disabled': 'Disabled',
  'App Theme': 'App Theme',
  'Language': 'Language',
  'Change Personal Info': 'Change Personal Info',
  'Change Password': 'Change Password',
  'Need Help?': 'Need Help?',
  'Delete Account': 'Delete Account',
  'Privacy Policy': 'Privacy Policy',
  'Terms & Conditions': 'Terms & Conditions',
  'Select Language': 'Select Language',
  'اختر اللغة': 'Select Language',

  // ── Profile / Edit ────────────────────────────────────────────────────────────
  'Edit Profile': 'Edit Profile',
  'Save Changes': 'Save Changes',
  'Full Name': 'Full Name',
  'Email': 'Email',
  'Phone': 'Phone',
  'Date of Birth': 'Date of Birth',
  'Gender': 'Gender',
  'Male': 'Male',
  'Female': 'Female',
  'Profile updated successfully!': 'Profile updated successfully!',
  'Could not load profile': 'Could not load profile',
  'Try Again': 'Try Again',

  // ── Auth ──────────────────────────────────────────────────────────────────────
  'Login': 'Login',
  'Sign Up': 'Sign Up',
  'Password': 'Password',
  'Confirm Password': 'Confirm Password',
  'Forgot Password?': 'Forgot Password?',

  // ── Navigation ────────────────────────────────────────────────────────────────
  'Home': 'Home',
  'Courts': 'Courts',
  'Bookings': 'Bookings',
  'Settings': 'Settings',

  // ── Courts ────────────────────────────────────────────────────────────────────
  'My Courts': 'My Courts',
  'Add Court': 'Add Court',
  'Edit Court': 'Edit Court',
  'Court Name': 'Court Name',
  'Location': 'Location',
  'Price per Hour': 'Price per Hour',
  'Amenities': 'Amenities',
  'Photos': 'Photos',
  'Save': 'Save',

  // ── Bookings ──────────────────────────────────────────────────────────────────
  'Upcoming': 'Upcoming',
  'Past': 'Past',
  'Cancelled': 'Cancelled',
  'No bookings found': 'No bookings found',

  // ── Common ────────────────────────────────────────────────────────────────────
  'Loading...': 'Loading...',
  'Error': 'Error',
  'Success': 'Success',
  'Confirm': 'Confirm',
  'Delete': 'Delete',
  'Remove': 'Remove',
  'Close': 'Close',
  'Back': 'Back',
  'Next': 'Next',
  'Done': 'Done',
  'Search': 'Search',
  'No results found': 'No results found',
  'Something went wrong': 'Something went wrong',
  'No internet connection': 'No internet connection',
  'Retry': 'Retry',

  // ── Help Center ───────────────────────────────────────────────────────────────
  'Help Center': 'Help Center',
  'FAQ': 'FAQ',
  'Contact Support': 'Contact Support',
  'Send Message': 'Send Message',

  // ── Change Password ───────────────────────────────────────────────────────────
  'Current Password': 'Current Password',
  'New Password': 'New Password',
  'Update Password': 'Update Password',

  // ── Delete Account ────────────────────────────────────────────────────────────
  'Delete My Account': 'Delete My Account',
  'This action cannot be undone.': 'This action cannot be undone.',

  // ── Theme ─────────────────────────────────────────────────────────────────────
  'Dark Mode': 'Dark Mode',
  'Light Mode': 'Light Mode',
  'System Default': 'System Default',

  // ── Booking Requests ──────────────────────────────────────────────────────────
  'Booking Requests': 'Booking Requests',
  'Accept': 'Accept',
  'Decline': 'Decline',
  'All': 'All',
  'Try changing the filter above': 'Try changing the filter above',
  'requests': 'requests',
  'request': 'request',
  'booking declined': 'booking declined',
  'booking accepted ✓': 'booking accepted ✓',
  'Pending': 'Pending',
  'Approved': 'Approved',
  'Declined': 'Declined',

  // ── Dashboard / Add Court ───────────────────────────────────────────────────
  'Good morning,': 'Good morning,',
  'Good afternoon,': 'Good afternoon,',
  'Good evening,': 'Good evening,',
  'Notifications': 'Notifications',
  'No notifications yet': 'No notifications yet',
  "You're all caught up! New alerts\nwill appear here.": "You're all caught up! New alerts\nwill appear here.",
  'OVERVIEW': 'OVERVIEW',
  "Today's Bookings": "Today's Bookings",
  'Weekly Earnings': 'Weekly Earnings',
  'Pending Requests': 'Pending Requests',
  'Total Courts': 'Total Courts',
  'Weekly Revenue': 'Weekly Revenue',
  'Last 7 days': 'Last 7 days',
  'Add New Court': 'Add New Court',
  'No Data Yet': 'No Data Yet',
  'Your dashboard will populate once you\nadd courts and receive bookings.': 'Your dashboard will populate once you\nadd courts and receive bookings.',
  'Court created successfully!': 'Court created successfully!',
  'Save Court': 'Save Court',
  'Add Your Court': 'Add Your Court',
  'Basic Details': 'Basic Details',
  "Enter your court's name": "Enter your court's name",
  'Court name is required': 'Court name is required',
  'Select a Sport Type': 'Select a Sport Type',
  'Please select a sport type': 'Please select a sport type',
  "Enter your court's address": "Enter your court's address",
  'Address is required': 'Address is required',
  'Tap to pin location': 'Tap to pin location',
  'Pricing & Photos': 'Pricing & Photos',
  'Price per hour (e.g. 200)': 'Price per hour (e.g. 200)',
  'Price is required': 'Price is required',
  'Court Photos': 'Court Photos',
  'Tap to upload images': 'Tap to upload images',
  'PNG, JPG up to 5MB': 'PNG, JPG up to 5MB',
  'Lights': 'Lights',
  'Showers': 'Showers',
  'Cafe': 'Cafe',
  'Equipment': 'Equipment',
  'Parking': 'Parking',
  'Wi-Fi': 'Wi-Fi',
  'Football': 'Football',
  'Basketball': 'Basketball',
  'Tennis': 'Tennis',
  'Padel': 'Padel',
  'Mon': 'Mon',
  'Tue': 'Tue',
  'Wed': 'Wed',
  'Thu': 'Thu',
  'Fri': 'Fri',
  'Sat': 'Sat',
  'Sun': 'Sun',
};

// ─── Arabic ─────────────────────────────────────────────────────────────────────

const Map<String, String> _ar = {
  // ── Settings ─────────────────────────────────────────────────────────────────
  'Profile & Settings': 'الملف الشخصي والإعدادات',
  'Manage your account': 'إدارة حسابك',
  'Log Out': 'تسجيل الخروج',
  'Cancel': 'إلغاء',
  'Are you sure you want to log out\nof your account?':
      'هل أنت متأكد أنك تريد\nتسجيل الخروج من حسابك؟',
  'Push Notifications': 'الإشعارات',
  'Enabled': 'مفعّل',
  'Disabled': 'معطّل',
  'App Theme': 'مظهر التطبيق',
  'Language': 'اللغة',
  'Change Personal Info': 'تغيير البيانات الشخصية',
  'Change Password': 'تغيير كلمة المرور',
  'Need Help?': 'تحتاج مساعدة؟',
  'Delete Account': 'حذف الحساب',
  'Privacy Policy': 'سياسة الخصوصية',
  'Terms & Conditions': 'الشروط والأحكام',
  'Select Language': 'اختر اللغة',
  'اختر اللغة': 'اختر اللغة',

  // ── Profile / Edit ────────────────────────────────────────────────────────────
  'Edit Profile': 'تعديل الملف الشخصي',
  'Save Changes': 'حفظ التغييرات',
  'Full Name': 'الاسم الكامل',
  'Email': 'البريد الإلكتروني',
  'Phone': 'رقم الهاتف',
  'Date of Birth': 'تاريخ الميلاد',
  'Gender': 'الجنس',
  'Male': 'ذكر',
  'Female': 'أنثى',
  'Profile updated successfully!': 'تم تحديث الملف الشخصي بنجاح!',
  'Could not load profile': 'تعذّر تحميل الملف الشخصي',
  'Try Again': 'حاول مجدداً',

  // ── Auth ──────────────────────────────────────────────────────────────────────
  'Login': 'تسجيل الدخول',
  'Sign Up': 'إنشاء حساب',
  'Password': 'كلمة المرور',
  'Confirm Password': 'تأكيد كلمة المرور',
  'Forgot Password?': 'نسيت كلمة المرور؟',

  // ── Navigation ────────────────────────────────────────────────────────────────
  'Home': 'الرئيسية',
  'Courts': 'الملاعب',
  'Bookings': 'الحجوزات',
  'Settings': 'الإعدادات',

  // ── Courts ────────────────────────────────────────────────────────────────────
  'My Courts': 'ملاعبي',
  'Add Court': 'إضافة ملعب',
  'Edit Court': 'تعديل الملعب',
  'Court Name': 'اسم الملعب',
  'Location': 'الموقع',
  'Price per Hour': 'السعر في الساعة',
  'Amenities': 'المرافق',
  'Photos': 'الصور',
  'Save': 'حفظ',

  // ── Bookings ──────────────────────────────────────────────────────────────────
  'Upcoming': 'القادمة',
  'Past': 'السابقة',
  'Cancelled': 'الملغاة',
  'No bookings found': 'لا توجد حجوزات',

  // ── Common ────────────────────────────────────────────────────────────────────
  'Loading...': 'جارٍ التحميل...',
  'Error': 'خطأ',
  'Success': 'نجح',
  'Confirm': 'تأكيد',
  'Delete': 'حذف',
  'Remove': 'إزالة',
  'Close': 'إغلاق',
  'Back': 'رجوع',
  'Next': 'التالي',
  'Done': 'تم',
  'Search': 'بحث',
  'No results found': 'لا توجد نتائج',
  'Something went wrong': 'حدث خطأ ما',
  'No internet connection': 'لا يوجد اتصال بالإنترنت',
  'Retry': 'إعادة المحاولة',

  // ── Help Center ───────────────────────────────────────────────────────────────
  'Help Center': 'مركز المساعدة',
  'FAQ': 'الأسئلة الشائعة',
  'Contact Support': 'تواصل مع الدعم',
  'Send Message': 'إرسال رسالة',

  // ── Change Password ───────────────────────────────────────────────────────────
  'Current Password': 'كلمة المرور الحالية',
  'New Password': 'كلمة المرور الجديدة',
  'Update Password': 'تحديث كلمة المرور',

  // ── Delete Account ────────────────────────────────────────────────────────────
  'Delete My Account': 'حذف حسابي',
  'This action cannot be undone.': 'لا يمكن التراجع عن هذا الإجراء.',

  // ── Theme ─────────────────────────────────────────────────────────────────────
  'Dark Mode': 'الوضع الداكن',
  'Light Mode': 'الوضع الفاتح',
  'System Default': 'إعداد النظام',

  // ── Booking Requests ──────────────────────────────────────────────────────────
  'Booking Requests': 'طلبات الحجز',
  'Accept': 'قبول',
  'Decline': 'رفض',
  'All': 'الكل',
  'Try changing the filter above': 'جرب تغيير الفلتر في الأعلى',
  'requests': 'طلبات',
  'request': 'طلب',
  'booking declined': 'تم رفض الحجز',
  'booking accepted ✓': 'تم قبول الحجز ✓',
  'Pending': 'قيد الانتظار',
  'Approved': 'مقبول',
  'Declined': 'مرفوض',

  // ── Dashboard / Add Court ───────────────────────────────────────────────────
  'Good morning,': 'صباح الخير،',
  'Good afternoon,': 'مساء الخير،',
  'Good evening,': 'مساء الخير،',
  'Notifications': 'الإشعارات',
  'No notifications yet': 'لا توجد إشعارات بعد',
  "You're all caught up! New alerts\nwill appear here.": "أنت على اطلاع بكل شيء! ستظهر التنبيهات الجديدة هنا.",
  'OVERVIEW': 'نظرة عامة',
  "Today's Bookings": "حجوزات اليوم",
  'Weekly Earnings': 'الأرباح الأسبوعية',
  'Pending Requests': 'الطلبات المعلقة',
  'Total Courts': 'إجمالي الملاعب',
  'Weekly Revenue': 'الإيرادات الأسبوعية',
  'Last 7 days': 'آخر 7 أيام',
  'Add New Court': 'إضافة ملعب جديد',
  'No Data Yet': 'لا توجد بيانات بعد',
  'Your dashboard will populate once you\nadd courts and receive bookings.': 'سيتم ملء لوحة التحكم الخاصة بك بمجرد إضافة الملاعب وتلقي الحجوزات.',
  'Court created successfully!': 'تم إنشاء الملعب بنجاح!',
  'Save Court': 'حفظ الملعب',
  'Add Your Court': 'إضافة ملعبك',
  'Basic Details': 'التفاصيل الأساسية',
  "Enter your court's name": "أدخل اسم الملعب الخاص بك",
  'Court name is required': 'اسم الملعب مطلوب',
  'Select a Sport Type': 'اختر نوع الرياضة',
  'Please select a sport type': 'الرجاء اختيار نوع الرياضة',
  "Enter your court's address": "أدخل عنوان الملعب الخاص بك",
  'Address is required': 'العنوان مطلوب',
  'Tap to pin location': 'اضغط لتحديد الموقع على الخريطة',
  'Pricing & Photos': 'الأسعار والصور',
  'Price per hour (e.g. 200)': 'السعر في الساعة (مثال: 200)',
  'Price is required': 'السعر مطلوب',
  'Court Photos': 'صور الملعب',
  'Tap to upload images': 'اضغط لتحميل الصور',
  'PNG, JPG up to 5MB': 'صيغ PNG, JPG حتى 5 ميجابايت',
  'Lights': 'إضاءة',
  'Showers': 'دش / غرف غسيل',
  'Cafe': 'كافيه / مقهى',
  'Equipment': 'معدات رياضية',
  'Parking': 'موقف سيارات',
  'Wi-Fi': 'واي فاي',
  'Football': 'كرة القدم',
  'Basketball': 'كرة السلة',
  'Tennis': 'التنس',
  'Padel': 'البادل',
  'Mon': 'الاثنين',
  'Tue': 'الثلاثاء',
  'Wed': 'الأربعاء',
  'Thu': 'الخميس',
  'Fri': 'الجمعة',
  'Sat': 'السبت',
  'Sun': 'الأحد',
};
