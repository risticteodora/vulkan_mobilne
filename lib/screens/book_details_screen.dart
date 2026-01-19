import 'package:flutter/material.dart';
import 'package:moj_projekat/providers/catalog_provider.dart';
import 'package:provider/provider.dart';

class BookDetailsScreen extends StatelessWidget{
  static const path= '/book';
  final String bookId;

  const BookDetailsScreen({
    super.key,
    required this.bookId
  });
  
  @override
  Widget build(BuildContext context) {
    final catalog= context.watch<CatalogProvider>();
    final book=catalog.books.firstWhere((b)=> b.id == bookId);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalji knjige'),),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(book.image, height: 200,fit: BoxFit.cover,),
          ),
          const SizedBox(height: 12,),
          Text(book.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6,),
          Text('Kategorija: ${book.categoryId}'),
          const SizedBox(height: 8,),
          Text(book.price.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12,),
          Text(book.description),
        ],
      ),
    );
  }
  
}