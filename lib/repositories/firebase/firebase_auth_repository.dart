import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moj_projekat/models/user_role.dart';
import 'package:moj_projekat/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository{
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  
  @override
  Future<AuthSession> getSession() async {
     final user = auth.currentUser;
    if (user == null) return AuthSession.guest;

    final role = await _loadRole(user.uid);
    return AuthSession(
      isLoggedIn: true,
      role: role,
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
    );
  }
  
  @override
  Future<AuthSession> login( {
    required String email,
    required String password,
    }) async {
    final cred = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = cred.user;
    if (user == null) return AuthSession.guest;

    final role = await _loadRole(user.uid);
    return AuthSession(
      isLoggedIn: true,
      role: role,
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
    );
  }
  
  @override
  Future<void> logout() async {
    await auth.signOut();
  }
  
  @override
  Future<AuthSession> register({
    required String displayName,
    required String email,
    required String password,
  }) async {
    final cred = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = cred.user;
    if (user == null) return AuthSession.guest;

    await user.updateDisplayName(displayName);
    await user.reload();
   
    await db.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': email,
      'displayName': displayName,
      'role': 'user', 
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    return AuthSession(
      isLoggedIn: true,
      role: UserRole.user,
      uid: user.uid,
      email: email,
      displayName: displayName,
    );
  }

  Future<UserRole> _loadRole(String uid) async {
    try {
      final doc = await db.collection('users').doc(uid).get();
      final data = doc.data();

      final roleStr = (data?['role'] as String?)?.toLowerCase();

      if (roleStr == 'admin') return UserRole.admin;
      if (roleStr == 'user') return UserRole.user;

      return UserRole.user;
    } catch (_) {

      return UserRole.user;
    }
  }
}