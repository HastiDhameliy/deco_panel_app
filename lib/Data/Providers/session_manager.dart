import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String authTokenKey = "auth_token";
  final String userIdKey = "user_id";
  final String isLocationKey = "isAccessLocation";

  ///set data into shared preferences like this

  Future<void> saveAuthToken(String authToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(authTokenKey, authToken);
  }

  Future<void> saveUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userIdKey, userId);
  }

  Future<void> saveAccessLocation(int shopId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(isLocationKey, shopId);
  }

  ///get value from shared preferences

  Future<String?> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? authToken;
    authToken = pref.getString(authTokenKey);
    return authToken;
  }

  Future<String?> getUserId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId;
    userId = pref.getString(userIdKey);
    return userId;
  }

  Future<int?> getAccessLocation() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? shopId;
    shopId = pref.getInt(isLocationKey);
    return shopId;
  }

  ///clear data from shared preferences

  Future<void> clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
