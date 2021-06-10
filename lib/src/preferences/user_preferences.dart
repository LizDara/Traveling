import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences _preferences;

  initPreferences() async {
    this._preferences = await SharedPreferences.getInstance();
  }

  get token {
    return _preferences.getString('token') ?? '';
  }

  set token(String token) {
    _preferences.setString('token', token);
  }

  get lastPage {
    return _preferences.getString('lastPage') ?? 'signin';
  }

  set lastPage(String page) {
    _preferences.setString('lastPage', page);
  }

  clearPreferences() {
    _preferences.clear();
  }
}
