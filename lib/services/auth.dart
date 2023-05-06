import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../new_models/user.dart';

class AuthServiceWin {
  static const winBaseUrl = 'http://localhost:5000';
  static Dio _dio = Dio(
    BaseOptions(baseUrl: winBaseUrl),
  )..interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true));

  static Future<void> winLogin(String email, String password) async {
    try {
      final response = await _dio
          .post('/login', data: {'email': email, 'password': password});
      final accessToken = response.data['access_token'];
      _dio.options = _dio.options
          .copyWith(headers: {'Authorization': 'Bearer $accessToken'});
    } catch (error) {
      throw Exception('Failed to login: $error');
    }
  }

  static Future<void> winLogout() async {
    try {
      await _dio.post(
        '/logout',
      );
            User.get().logout();

      _dio.options = BaseOptions();
    } catch (error) {
      throw Exception('Failed to logout: $error');
    }
  }

  static Future<void> mobLogin(String email, String password) async {
    try {
      final response = await _dio
          .post('/login', data: {'email': email, 'password': password});
      final accessToken = response.data['access_token'];
      _dio.options = _dio.options
          .copyWith(headers: {'Authorization': 'Bearer $accessToken'});
    } catch (error) {
      throw Exception('Failed to login: $error');
    }
  }

  static Future<void> mobLogout() async {
    try {
      await _dio.post(
        '/logout',
      );
      User.get().logout();
      _dio.options = BaseOptions();
    } catch (error) {
      throw Exception('Failed to logout: $error');
    }
  }

  static Future<User> getCurrentUser() async {
    try {
      final response = await _dio.get(
        '/user',
      );
      final userData = response.data;
      final user = User.fromJson(userData);
      return user;
    } catch (error) {
      throw Exception('Failed to get current user: $error');
    }
  }

  static Future<void> updateUser(
      String accessToken,
      String email,
      String secondName,
      String firstName,
      String patronymic,
      String mobileNumber) async {
    try {
      await _dio.put(
        '/update_user',
        data: {
          'email': email,
          'second_name': secondName,
          'first_name': firstName,
          'patronymic': patronymic,
          'mobile_number': mobileNumber
        },
      );
    } catch (error) {
      throw Exception('Failed to update user: $error');
    }
  }
}

class AuthServiceMob {
  static const mobBaseUrl = 'http://10.0.2.2:5000';
  static Dio _dio = Dio(
    BaseOptions(baseUrl: mobBaseUrl),
  )..interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true));

  static Future<void> mobLogin(String email, String password) async {
    try {
      final response = await _dio
          .post('/login', data: {'email': email, 'password': password});
      final accessToken = response.data['access_token'];
      _dio.options = _dio.options
          .copyWith(headers: {'Authorization': 'Bearer $accessToken'});
    } catch (error) {
      throw Exception('Failed to login: $error');
    }
  }

  static Future<void> mobLogout() async {
    try {
      await _dio.post(
        '/logout',
      );
      User.get().logout();

      _dio.options = BaseOptions();
    } catch (error) {
      throw Exception('Failed to logout: $error');
    }
  }

  static Future<User> mobGetCurrentUser() async {
    try {
      final response = await _dio.get(
        '/user',
      );
      final userData = response.data;
      final user = User.fromJson(userData);
      return user;
    } catch (error) {
      throw Exception('Failed to get current user: $error');
    }
  }
}
