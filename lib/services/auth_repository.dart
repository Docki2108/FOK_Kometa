import 'dart:math';

import 'package:fok_kometa/new_models/user.dart';
import 'package:fok_kometa/services/auth.dart';

abstract class AuthRepository {
  static Future<User?> winLogin(String email, String password) async {
    try {
      await AuthServiceWin.winLogin(email, password);
      var userData = await AuthServiceWin.getCurrentUser();
      if (userData.role != "Manager") {
        AuthServiceWin.winLogout();
        throw Exception("Ошибка входа");
      }
      return userData;
    } catch (e) {
      return null;
    }
  }

  static Future<User?> mobLogin(String email, String password) async {
    try {
      await AuthServiceMob.mobLogin(email, password);
      var userData = await AuthServiceMob.mobGetCurrentUser();
      if (userData.role != "Client") {
        AuthServiceMob.mobLogout();
        throw Exception("Ошибка входа");
      }
      return userData;
    } catch (e) {
      return null;
    }
  }
}
