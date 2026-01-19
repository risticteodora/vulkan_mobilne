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
            child: Image.asset(book.image, height: 400, width: 200,),
          ),
          const SizedBox(height: 30,),
          Text(book.title, style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6,),
          Text('Kategorija: ${book.categoryId}'),
          const SizedBox(height: 8,),
          Text(book.price.toString() , style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12,),
          Row(
                children: const [
                  Expanded(child: Divider(thickness: 1)),
                  SizedBox(width: 12),
                  Text("O proizvodu", style: const TextStyle(fontSize: 22),),
                  SizedBox(width: 12),
                  Expanded(child: Divider(thickness: 1)),
                ],
          ),
          const SizedBox(height: 8,),
          Text(book.description),
        ],
      ),
    );
  }
  
}