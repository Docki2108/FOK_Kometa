import 'package:dio/dio.dart';

import '../new_models/user.dart';

class AuthService {
  static const baseUrl = 'http://localhost:5000/login';

  final _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<String> login(String email, String password) async {
    try {
      final response = await _dio
          .post('/login', data: {'email': email, 'password': password});
      final accessToken = response.data['access_token'];
      return accessToken;
    } catch (error) {
      throw Exception('Failed to login: $error');
    }
  }

  Future<void> logout(String accessToken) async {
    try {
      await _dio.post('/logout',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
    } catch (error) {
      throw Exception('Failed to logout: $error');
    }
  }

  Future<User> getCurrentUser(String accessToken) async {
    try {
      final response = await _dio.get('/users/me',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
      final userData = response.data;
      final user = User.fromJson(userData);
      return user;
    } catch (error) {
      throw Exception('Failed to get current user: $error');
    }
  }

  Future<void> updateUser(String accessToken, String email, String secondName,
      String firstName, String patronymic, String mobileNumber) async {
    try {
      await _dio.put('/update_user',
          data: {
            'email': email,
            'second_name': secondName,
            'first_name': firstName,
            'patronymic': patronymic,
            'mobile_number': mobileNumber
          },
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
    } catch (error) {
      throw Exception('Failed to update user: $error');
    }
  }
}
