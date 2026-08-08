import 'package:moj_projekat/models/book.dart';
import 'package:moj_projekat/models/category.dart';
import 'package:moj_projekat/repositories/book_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseBookRepository implements BooksRepository{
  final FirebaseFirestore db =FirebaseFirestore.instance;

  @override
  Future<List<Book>> getBooks() async {
    //final snap = await db.collection('books').orderBy('createdAt', descending: true).get();
    final snap = await db.collection('books').get();

    return snap.docs.map((d) {
      final data = d.data();
      data['id'] ??= d.id; 
      return Book.fromJson(data);
    }).toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    final snap = await db.collection('categories').orderBy('order').get();

    return snap.docs.map((d) {
      final data = d.data();
      data['id'] ??= d.id;
      return Category.fromJson(data);
    }).toList();
  }
  
}