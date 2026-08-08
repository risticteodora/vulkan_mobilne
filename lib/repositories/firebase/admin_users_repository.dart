import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUsersRepository {
  final db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamUsers() {
    return db.collection('users').orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> setRole(String uid, String role) {
    return db.collection('users').doc(uid).set({'role': role}, SetOptions(merge: true));
  }
}
