import 'package:moj_projekat/models/user_role.dart';

class AuthSession{
  final bool isLoggedIn;
  final UserRole role;
  final String? email;
  final String? displayName;

  const AuthSession({
    required this.isLoggedIn,
    required this.role,
    this.email,
    this.displayName
  });

  static const guest= AuthSession(isLoggedIn: false, role: UserRole.guest);
}

abstract class AuthRepository {
  Future<AuthSession> getSession();
  Future<AuthSession> login ({
    required String email,
    required String password
  });
  Future<AuthSession> register({
    required String displayName,
    required String email,
    required String password
  });
  Future<void> logout();
}