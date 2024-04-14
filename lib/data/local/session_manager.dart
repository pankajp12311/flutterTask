import 'package:get_storage/get_storage.dart';

/// Storage manager to store and retrieve data from local storage
class StorageManager {
  static final StorageManager _instance = StorageManager._internal();

  factory StorageManager() {
    return _instance;
  }

  StorageManager._internal();

  final String authToken = 'auth_token';
  final String addData = 'timer_data';

  GetStorage localStorage = GetStorage();

  /// Set auth token after login-signup
  void setAuthToken(String token) {
    localStorage.write(authToken, token);
  }

  String? getAuthToken() {
    return localStorage.read(authToken);
  }

  /// Set auth token after login-signup
  void setTimerData(List data) {
    localStorage.write(addData, data);
  }

  List? getTimerData() {
    return localStorage.read(addData);
  }

  /// Clear all data stored in local
  void clearSession() {
    localStorage.erase();
  }
}
