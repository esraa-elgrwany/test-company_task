import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
  static late SharedPreferences preferences;

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required dynamic data,
    required String key,
  }) {
    if (data is String) {
      return preferences.setString(key, data);
    } else if (data is int) {
      return preferences.setInt(key, data);
    } else if (data is double) {
      return preferences.setDouble(key, data);
    } else if (data is bool) {
      return preferences.setBool(key, data);
    } else {
      return preferences.setString(key, jsonEncode(data));
    }
  }

  static dynamic getData({required String key}) {
    var value = preferences.get(key);
    print("Retrieved $key: $value");
    return value;
  }

  static Future<bool> removeData(String key) async {
    return await preferences.remove(key);
  }
}
