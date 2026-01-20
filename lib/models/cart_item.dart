import 'package:moj_projekat/models/book.dart';

class CartItem {
  final Book book;
  final int qty;

  const CartItem({
    required this.book,
    required this.qty
  });
  
  CartItem copyWith({int? qty})=> CartItem(book: book, qty: qty ?? this.qty);
}