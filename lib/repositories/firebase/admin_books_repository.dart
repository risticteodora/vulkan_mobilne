import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moj_projekat/models/book.dart';

class AdminBooksRepository {
  final _db = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> get _col => _db.collection('books');

  Stream<List<Book>> streamBooks() {
    return _col.snapshots().map((snap) {
      return snap.docs.map((d) {
        final data = d.data();
        data['id'] = d.id; 
        return Book.fromJson(data);
      }).toList();
    });
  }

  Future<void> createBook(Book b) async {
    await _col.doc(b.id).set(b.toJson());
  }

  Future<void> updateBook(Book b) async {
    await _col.doc(b.id).set(b.toJson(), SetOptions(merge: true));
  }

  Future<void> deleteBook(String id) async {
    await _col.doc(id).delete();
  }
}
