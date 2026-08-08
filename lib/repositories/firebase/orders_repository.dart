import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersRepository {
  final db = FirebaseFirestore.instance;

  Future<void> createOrder({
    required String userId,
    required List<Map<String, dynamic>> items,
    required int total,
  }) async {
    final doc = db.collection('orders').doc();
    await doc.set({
      'id': doc.id,
      'userId': userId,
      'items': items,
      'total': total,
      'status': 'created',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateStatus(String orderId, String status) async {
    await db.collection('orders').doc(orderId).update({'status': status});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamOrdersForUser(String userId) {
    return db.collection('orders')
      .where('userId', isEqualTo: userId)
      .orderBy('createdAt', descending: true)
      .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllOrders() {
    return db.collection('orders')
      .orderBy('createdAt', descending: true)
      .snapshots();
  }
}