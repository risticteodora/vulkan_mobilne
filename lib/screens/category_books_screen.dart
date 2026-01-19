import 'package:flutter/material.dart';
import 'package:moj_projekat/providers/catalog_provider.dart';
import 'package:moj_projekat/widgets/book_card.dart';
import 'package:moj_projekat/widgets/empty_state.dart';
import 'package:provider/provider.dart';

class CategoryBooksScreen extends StatelessWidget{
  static const path ='/category';
  final String? categoryId;
  final String categoryName;

  const CategoryBooksScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });
  
  @override
  Widget build(BuildContext context) {
    final catalog=context.watch<CatalogProvider>();

    final list=categoryId == null ? catalog.books: catalog.books.where((b)=> b.categoryId == categoryId).toList();

    return Scaffold(
      appBar: AppBar(title: Text(categoryName),),
      body: list.isEmpty ? const EmptyState(title: "Nema knjiga", subtitle: "Ova kategorija je prazna") : 
        GridView.builder(
          padding: const EdgeInsets.all(12), 
          itemCount: list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.72
          ),
          itemBuilder: (_,i)=> BookCard(book: list[i]),
        ),
    );
  }
  
}