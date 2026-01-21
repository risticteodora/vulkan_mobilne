import 'package:flutter/material.dart';
import 'package:moj_projekat/models/user_role.dart';
import 'package:moj_projekat/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier{
  final AuthRepository _repo;

  AuthSession _session=AuthSession.guest;
  bool _loading =false;

  AuthProvider(
    this._repo
  );

  AuthSession get session=> _session;
  bool get isLoading=> _loading;
  bool get isLoggedIn=> _session.isLoggedIn;
  UserRole get role => _session.role;

  Future<void> init() async{
    _session= await _repo.getSession();
    notifyListeners();
  }

  Future<void> login( String email, String password) async{
    _loading =true;
    notifyListeners();
    try{
      _session= await _repo.login(email: email, password: password);
    } finally{
      _loading= false;
      notifyListeners();
    }
  }

  Future<void> register(String name, String email, String pass) async{
    _loading =true;
    notifyListeners();
    try{
      _session= await _repo.register(displayName: name, email: email, password: pass);
    }finally{
      _loading=false;
      notifyListeners();
    }
  }

  Future<void> logout() async{
    await _repo.logout();
    _session= AuthSession.guest;
    notifyListeners();
  }

}