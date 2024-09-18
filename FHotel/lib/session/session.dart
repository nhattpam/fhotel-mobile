import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static SessionManager? _instance;

  factory SessionManager() => _instance ??= SessionManager._();

  SessionManager._();

  SharedPreferences? _preferences;

  String? userId;

  // Initialize the session manager
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save the user ID to the session
  void setUserId(String id) {
    _preferences?.setString('userId', id);
  }

  // Save the leaner ID to the session
  void setLearnerId(String id) {
    _preferences?.setString('learnerId', id);
  }
  void setTutorId(String id) {
    _preferences?.setString('tutorId', id);
  }

  // Get the user ID from the session
  String? getUserId() {
    return _preferences?.getString('userId');
  }

  String? getLearnerId() {
    return _preferences?.getString('learnerId');
  }
  String? getTutorId() {
    return _preferences?.getString('tutorId');
  }

  // Clear user session data (logout)
  void clearSession() {
    _preferences?.clear();
  }
}
