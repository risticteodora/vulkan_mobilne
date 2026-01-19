import 'package:flutter/material.dart';
import 'package:moj_projekat/models/book.dart';
import 'package:moj_projekat/models/category.dart';
import 'package:moj_projekat/repositories/book_repository.dart';

class CatalogProvider extends ChangeNotifier{
  final BooksRepository _repo;
  CatalogProvider(this._repo);

  bool loading=false;
  List<Book> books= [];
  List<Category>categories=[];

  String query= '';
  String? selectedCategoryId;

  Future<void> load() async{
    loading=true;
    notifyListeners();
    try{
      categories=await _repo.getCategories();
      books=await _repo.getBooks();
    }
    finally{
      loading=false;
      notifyListeners();
    }
  }

  List<Book> get filtered{
    var list= books;
    if(selectedCategoryId!= null){
      list= list.where((b)=> b.categoryId == selectedCategoryId).toList();
    }
    if(query.trim().isNotEmpty){
      final q= query.toLowerCase();
      list= list.where((b)=> b.title.toLowerCase().contains(q)).toList();
    }
    return list;
  }
  
  List<Book> get latest => books.take(10).toList();

  void setQuery(String v){
    query=v;
    notifyListeners();
  }

  void setCategory(String? id){
    selectedCategoryId=id;
    notifyListeners();
  }
}