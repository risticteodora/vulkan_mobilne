import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:moj_projekat/models/book.dart';
import 'package:moj_projekat/models/category.dart';
import 'package:moj_projekat/repositories/book_repository.dart';

class MockBookRepository implements BooksRepository{
  @override
  Future<List<Book>> getBooks() async {
    final raw = await rootBundle.loadString('assets/mock/books.json');
    final list = (jsonDecode(raw)as List).cast<Map<String, dynamic>>();
    return list.map(Book.fromJson).toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    final raw = await rootBundle.loadString('assets/mock/categories.json');
    final list = (jsonDecode(raw)as List).cast<Map<String, dynamic>>();
    return list.map(Category.fromJson).toList();
  }
  
}