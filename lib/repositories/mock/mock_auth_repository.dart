import 'package:moj_projekat/models/user_role.dart';
import 'package:moj_projekat/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository{
  AuthSession _session =AuthSession.guest;
  
  @override
  Future<AuthSession> getSession() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _session;
  }
  
  @override
  Future<AuthSession> login({required String email, required String password}) async{
    await Future.delayed(const Duration(milliseconds: 350));

    final role=email.toLowerCase().contains('admin')? UserRole.admin : UserRole.user;

    _session= AuthSession(
      isLoggedIn: true, 
      role: role,
      email: email,
      displayName: role == UserRole.admin ? 'Vulkan Admin' : 'Vulkan Korisnik'
    );
    return _session;
  }
  
  @override
  Future<void> logout() async{
    await Future.delayed(const Duration(milliseconds: 150));
    _session=AuthSession.guest;
  }
  
  @override
  Future<AuthSession> register({required String displayName, required String email, required String password}) async{
    await Future.delayed(const Duration(milliseconds: 450));

    _session=AuthSession(
      isLoggedIn: true, 
      role: UserRole.user,
      email: email,
      displayName: displayName
    );

    return _session;
  }

  
}