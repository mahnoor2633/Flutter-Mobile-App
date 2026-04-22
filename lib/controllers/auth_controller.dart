import '../enums/gender_enum.dart';
import '../models/subject.dart';

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

  final List<Subject> subjects = [
    Subject(
      name: 'Mobile App Development',
      description: 'This course covers Flutter fundamentals, widgets, state management, and app navigation.',
      schedule: 'Monday & Wednesday - 10:00 AM to 11:30 AM',
      bannerUrl: 'https://picsum.photos/seed/mobile/800/300',
    ),
    Subject(
      name: 'Software Re-engineering',
      description: 'This subject focuses on software maintenance, legacy modernization, and restructuring systems.',
      schedule: 'Tuesday - 1:00 PM to 3:00 PM',
      bannerUrl: 'https://picsum.photos/seed/software/800/300',
    ),
    Subject(
      name: 'MIS',
      description: 'Management Information Systems studies business processes, decision support, and enterprise systems.',
      schedule: 'Friday - 9:00 AM to 11:00 AM',
      bannerUrl: 'https://picsum.photos/seed/mis/800/300',
    ),
  ];

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