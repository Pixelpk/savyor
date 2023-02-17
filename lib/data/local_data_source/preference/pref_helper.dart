import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/logger/log.dart';
import '../../models/user.dart';
import 'i_pref_helper.dart';

class PrefHelper implements IPrefHelper {
  late final SharedPreferences _pref;

  PrefHelper(SharedPreferences preferences) : _pref = preferences;

  @override
  String? retrieveToken() {
    if (_pref.containsKey("userToken")) {
      return _pref.getString("userToken");
    } else {
      return null;
    }
  }

  @override
  void saveToken(value) {
    d("userToken => $value");
    _pref.setString("userToken", value);
  }

  @override
  void clear() {
    _pref.clear();
  }

  @override
  SharedPreferences get() {
    return _pref;
  }

  @override
  void removeToken() {
    _pref.remove('userToken');
  }

  @override
  void removeUser() {
    _pref.remove('user_data');
  }

  @override
  retrieveUser() {
    if (_pref.containsKey("user_data")) {
      Map<String, dynamic> jsonData = json.decode(_pref.getString("user_data")!);
      d("RETERIVED USER ${jsonData}");
      return User.fromJson(jsonData);
    } else {
      return null;
    }
  }

  @override
  void saveUser(res) {
    _pref.setString("user_data", json.encode(res.toJson()));
  }

  @override
  bool? getBool(String key) {
    if (_pref.containsKey(key)) {
      return _pref.getBool(key);
    }
    return null;
  }

  @override
  void saveBool(String key, bool value) {
    _pref.setBool(key, value);
  }
}
