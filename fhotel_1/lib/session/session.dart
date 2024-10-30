import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_export.dart';

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

  // Get the user ID from the session
  String? getUserId() {
    return _preferences?.getString('userId');
  }
  void setGuest(String guest) {
    _preferences?.setString('guest', guest);
  }

  // Get the user ID from the session
  String? getGuest() {
    return _preferences?.getString('guest');
  }
// Save search history to the session
  void setSearchHistory(List<String> searchHistory) {
    _preferences?.setString('searchHistory', json.encode(searchHistory));
  }

  // Get search history from the session
  List<String> getSearchHistory() {
    String? jsonString = _preferences?.getString('searchHistory');
    if (jsonString != null) {
      return List<String>.from(json.decode(jsonString));
    }
    return []; // Return an empty list if no history is found
  }

  void addHotelSession(Map<String, dynamic> hotelSession) {
    List<String> sessions = _preferences?.getStringList('hotelSessions') ?? [];
    sessions.add(json.encode(hotelSession));
    _preferences?.setStringList('hotelSessions', sessions);
  }

  // Get the list of hotel sessions
  List<Map<String, dynamic>> getHotelSessions() {
    List<String> sessions = _preferences?.getStringList('hotelSessions') ?? [];
    return sessions.map((session) => Map<String, dynamic>.from(json.decode(session))).toList();
  }
  // Clear user session data (logout)
  void clearSession() {
    _preferences?.clear();
  }
}
