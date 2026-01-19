import 'package:moj_projekat/models/book.dart';
import 'package:moj_projekat/models/category.dart';

abstract class BooksRepository {
  Future<List<Book>> getBooks();
  Future<List<Category>> getCategories();
}