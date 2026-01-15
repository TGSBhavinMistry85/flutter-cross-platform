import 'package:flutter/foundation.dart';

import 'package:flutter_application_1/features/auth/model/user.dart';

class SessionService {
  SessionService._(); // private constructor

  static final ValueNotifier<User?> _currentUser =
      ValueNotifier<User?>(null);

  /// Current logged-in user (read-only)
  static User? get currentUser => _currentUser.value;

  /// Listen to user session changes
  static ValueListenable<User?> get userListenable => _currentUser;

  /// Call this after successful login
  static void login(User user) {
    _currentUser.value = user;
  }

  /// Clear session and logout
  static void logout() {
    _currentUser.value = null;
  }

  /// Check if user is authenticated
  static bool get isAuthenticated => _currentUser.value != null;
}