import 'package:flutter/material.dart';
import 'package:moj_projekat/models/book.dart';
import 'package:moj_projekat/models/cart_item.dart';

class CartProvider extends ChangeNotifier{
  final Map<String, CartItem> _items={};

  List<CartItem> get items => _items.values.toList();

  void add(Book book){
    final existing= _items[book.id];
    if(existing == null){
      _items[book.id]= CartItem(book: book, qty: 1);
    }
    else{
      _items[book.id]= existing.copyWith(qty: existing.qty +1);
    }
    notifyListeners();
  }

  void remove(String bookId){
    _items.remove(bookId);
    notifyListeners();
  }

  void clear(){
    _items.clear();
    notifyListeners();
  }

  void setQty(String bookId, int qty){
    final item=_items[bookId];
    if(item == null)
      return;
    if(qty<=0){
      _items.remove(bookId);
    }else{
      _items[bookId]= item.copyWith(qty: qty);
    }
    notifyListeners();
  }

  int get total{
    int sum=0;
    for(final it in _items.values){
      sum +=it.book.price * it.qty;
    }
    return sum;
  }

  int get totalItems=> _items.values.fold(0, (a,b)=> a+b.qty);
}