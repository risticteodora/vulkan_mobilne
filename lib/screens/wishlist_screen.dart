import 'package:flutter/material.dart';
import 'package:moj_projekat/providers/catalog_provider.dart';
import 'package:moj_projekat/providers/wishlist_provider.dart';
import 'package:moj_projekat/widgets/book_card.dart';
import 'package:moj_projekat/widgets/empty_state.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget{
  static const path='/wishlist';
  const WishlistScreen({
    super.key
  });
  
  @override
  Widget build(BuildContext context) {
    final wishlist= context.watch<WishlistProvider>();
    final catalog= context.watch<CatalogProvider>();

    final wishedBooks= catalog.books.where((b) => wishlist.isWished(b.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista želja (${wishedBooks.length})'),
        actions: [
          IconButton(
            onPressed: wishedBooks.isEmpty ? null : wishlist.clear, 
            icon: const Icon(Icons.delete_forever)
          )
        ],
      ),
      body: wishedBooks.isEmpty ? 
      const EmptyState(
        title: 'Lista želja je prazna', 
        subtitle: 'Dodaj knjige klikom na ❤ na kartici knjige'
      ) : 
      GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: wishedBooks.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.55
        ), 
        itemBuilder: (_, i)=> BookCard(book: wishedBooks[i])
      ),
    );
  }
  
}