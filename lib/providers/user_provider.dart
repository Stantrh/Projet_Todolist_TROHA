import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class UserProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  String? _accessToken;
  String? _refreshToken;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;
  String? get accessToken => _accessToken;

  Future<void> signIn(String email, String password) async {
    final data = await _authService.signIn(email, password);
    if (data != null) {
      _accessToken = data['access_token'];
      _refreshToken = data['refresh_token'];
      _isAuthenticated = true;
      notifyListeners();
    } else {
      _isAuthenticated = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    if (_refreshToken != null) {
      await _authService.signOut(_refreshToken!);
    }
    _accessToken = null;
    _refreshToken = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> checkToken() async {
    if (_accessToken != null) {
      _isAuthenticated = await _authService.checkToken(_accessToken!);
      notifyListeners();
    }
  }

  Future<void> refreshToken() async {
    if (_refreshToken != null) {
      final data = await _authService.refreshToken(_refreshToken!);
      if (data != null) {
        _accessToken = data['access_token'];
        notifyListeners();
      }
    }
  }

  Future<void> signUp(String email, String password) async {
    await _authService.signUp(email, password);
  }
}