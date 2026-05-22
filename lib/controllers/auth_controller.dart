// lib/controllers/auth_controller.dart
import '../enums/gender_enum.dart';

class AuthController {
  static final AuthController instance = AuthController._internal();

  AuthController._internal();

  String? _registeredName;
  String? _registeredEmail;
  String? _registeredPassword;
  Gender? _registeredGender;
  bool _rememberMe = false;

  String? get registeredName => _registeredName;
  String? get registeredEmail => _registeredEmail;
  Gender? get registeredGender => _registeredGender;
  bool get rememberMe => _rememberMe;

  void registerUser({
    required String fullName,
    required String email,
    required String password,
    required Gender gender,
  }) {
    _registeredName = fullName;
    _registeredEmail = email;
    _registeredPassword = password;
    _registeredGender = gender;
  }

  bool login({
    required String email,
    required String password,
    required bool rememberMe,
  }) {
    if (_registeredEmail == email && _registeredPassword == password) {
      _rememberMe = rememberMe;
      return true;
    }
    return false;
  }

  void logout() {
    _rememberMe = false;
  }
}