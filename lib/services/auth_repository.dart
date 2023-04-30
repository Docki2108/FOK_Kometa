import 'package:fok_kometa/new_models/user.dart';
import 'package:fok_kometa/services/auth.dart';

abstract class AuthRepository {
  static Future<User?> login(String email, String password) async {
    try {
      await AuthService.login(email, password);
      var userData = await AuthService.getCurrentUser();
      return userData;
    } catch (e) {
      return null;
    }
  }
}
