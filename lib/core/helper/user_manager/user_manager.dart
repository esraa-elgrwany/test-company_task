import 'dart:convert';
import 'package:task/core/cache/shared_preferences.dart';
import 'package:task/features/login/data/models/login_model.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();
  factory UserManager() => _instance;
  UserManager._internal();

  UserDataModel? _user;

  Future<void> saveUser(UserDataModel user) async {
    _user = user;
    await CacheData.saveData(
      key: "userModel",
      data: jsonEncode(user.toJson()),
    );
  }


  UserDataModel? get user {
    if (_user != null) return _user;
    final raw = CacheData.getData(key: "userModel");
    if (raw != null) {
      _user = UserDataModel.fromJson(jsonDecode(raw));
    }
    return _user;
  }

  String get userId => user?.userId??"0";

  String get employee => user?.employee ?? "no name";

  String get cardNum=> user?.cardNum?? "";

  Future<void> clearUser() async {
    _user = null;
    await CacheData.removeData("userModel");
  }
}
