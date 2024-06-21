import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class AuthService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: '${dotenv.env['SUPABASE_URL']!}/auth/v1/',
    headers: {
      'apikey': dotenv.env['API_KEY'],
    },
  ));

  Future<Map<String, dynamic>?> signIn(String email, String password) async {
    try {
      final response = await _dio.post('token?grant_type=password', data: {
        'email': email,
        'password': password,
      });
      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut(String refreshToken) async {
    await _dio.post('logout', data: {'refresh_token': refreshToken});
  }

  Future<Map<String, dynamic>?> me(String accessToken) async {
    try {
      final response = await _dio.get('user', options: Options(headers: {
        'Authorization': 'Bearer $accessToken',
      }));
      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkToken(String accessToken) async {
    final meData = await me(accessToken);
    return meData != null;
  }

  Future<Map<String, dynamic>?> refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post('token', data: {
        'refresh_token': refreshToken,
      });
      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> signUp(String email, String password) async {
    try {
      final response = await _dio.post('signup', data: {
        'email': email,
        'password': password,
      });
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
