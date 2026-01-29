import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static SharedPreferences? _prefs;

  static const String _tokenKey = 'auth_token';
  static const String _onboardingKey = 'onboarding_completed';
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';
  static const String _userRoleKey = 'user_role';
  static const String _userEmailKey = 'user_email';
  static const String _userPhoneKey = 'user_phone';
  static const String _firstLaunchKey = 'first_launch';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> _ensureInitialized() async {
    if (_prefs == null) {
      await init();
    }
  }

  static Future<bool> isFirstLaunch() async {
    await _ensureInitialized();
    final isFirst = _prefs!.getBool(_firstLaunchKey) ?? true;

    if (isFirst) {
      await _prefs!.setBool(_firstLaunchKey, false);
    }

    return isFirst;
  }

  static Future<AppLaunchState> getAppLaunchState() async {
    await _ensureInitialized();

    final token = await getAuthToken();
    if (token != null && token.isNotEmpty) {
      final userData = await getUserData();
      if (userData != null) {
        return AppLaunchState.authenticated;
      } else {
        await clearAuthToken();
        return AppLaunchState.needsAuth;
      }
    }

    final onboardingCompleted = await isOnboardingCompleted();
    if (onboardingCompleted) {
      return AppLaunchState.needsAuth;
    }

    return AppLaunchState.needsOnboarding;
  }

  static Future<void> markFirstLaunchCompleted() async {
    await _ensureInitialized();
    await _prefs!.setBool(_firstLaunchKey, false);
  }

  static Future<String?> getAuthToken() async {
    await _ensureInitialized();
    return _prefs!.getString(_tokenKey);
  }

  static Future<void> setAuthToken(String token) async {
    await _ensureInitialized();
    await _prefs!.setString(_tokenKey, token);
  }

  static Future<void> clearAuthToken() async {
    await _ensureInitialized();
    await _prefs!.remove(_tokenKey);
  }

  static Future<bool> hasStoredToken() async {
    final token = await getAuthToken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> saveUserData({
    required int userId,
    required String name,
    required String role,
    String? email,
    String? phone,
    String? token,
  }) async {
    await _ensureInitialized();

    await _prefs!.setInt(_userIdKey, userId);
    await _prefs!.setString(_userNameKey, name);
    await _prefs!.setString(_userRoleKey, role);

    if (email != null && email.isNotEmpty) {
      await _prefs!.setString(_userEmailKey, email);
    }

    if (phone != null && phone.isNotEmpty) {
      await _prefs!.setString(_userPhoneKey, phone);
    }

    if (token != null && token.isNotEmpty) {
      await setAuthToken(token);
    }
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    await _ensureInitialized();

    final token = await getAuthToken();
    final userId = _prefs!.getInt(_userIdKey);
    final name = _prefs!.getString(_userNameKey);
    final role = _prefs!.getString(_userRoleKey);

    if (userId == null || name == null || role == null) {
      return null;
    }

    final email = _prefs!.getString(_userEmailKey);
    final phone = _prefs!.getString(_userPhoneKey);

    return {
      'token': token,
      'userId': userId,
      'name': name,
      'role': role,
      'email': email,
      'phone': phone,
    };
  }

  static Future<void> clearUserData() async {
    await _ensureInitialized();

    await clearAuthToken();
    await _prefs!.remove(_userIdKey);
    await _prefs!.remove(_userNameKey);
    await _prefs!.remove(_userRoleKey);
    await _prefs!.remove(_userEmailKey);
    await _prefs!.remove(_userPhoneKey);
  }

  static Future<int?> getUserId() async {
    await _ensureInitialized();
    return _prefs!.getInt(_userIdKey);
  }

  static Future<String?> getUserName() async {
    await _ensureInitialized();
    return _prefs!.getString(_userNameKey);
  }

  static Future<String?> getUserRole() async {
    await _ensureInitialized();
    return _prefs!.getString(_userRoleKey);
  }

  static Future<String?> getUserEmail() async {
    await _ensureInitialized();
    return _prefs!.getString(_userEmailKey);
  }

  static Future<String?> getUserPhone() async {
    await _ensureInitialized();
    return _prefs!.getString(_userPhoneKey);
  }

  static Future<bool> isOnboardingCompleted() async {
    await _ensureInitialized();
    return _prefs!.getBool(_onboardingKey) ?? false;
  }

  static Future<void> markOnboardingCompleted() async {
    await _ensureInitialized();
    await _prefs!.setBool(_onboardingKey, true);
  }

  static Future<void> resetOnboarding() async {
    await _ensureInitialized();
    await _prefs!.setBool(_onboardingKey, false);
  }

  static Future<bool> isLoggedIn() async {
    final token = await getAuthToken();
    if (token == null || token.isEmpty) return false;

    final userData = await getUserData();
    return userData != null;
  }

  static Future<void> logout() async {
    await clearUserData();
  }

  static Future<void> printStoredData() async {
    await _ensureInitialized();

    print('📱 Stored Session Data:');
    print('  Token: ${await getAuthToken()}');
    print('  User ID: ${await getUserId()}');
    print('  Name: ${await getUserName()}');
    print('  Role: ${await getUserRole()}');
    print('  Email: ${await getUserEmail()}');
    print('  Phone: ${await getUserPhone()}');
    print('  Onboarding: ${await isOnboardingCompleted()}');
    print('  First Launch: ${await isFirstLaunch()}');
  }
}

enum AppLaunchState {
  authenticated,    // مسجل دخول -> main layout
  needsAuth,        // مش مسجل -> start screen (login/register)
  needsOnboarding,  // أول مرة -> onboarding
}