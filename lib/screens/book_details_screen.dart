import 'package:flutter/material.dart';
import 'package:moj_projekat/providers/cart_provider.dart';
import 'package:moj_projekat/providers/catalog_provider.dart';
import 'package:moj_projekat/providers/wishlist_provider.dart';
import 'package:moj_projekat/util/money.dart';
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
    final wished= context.watch<WishlistProvider>().isWished(book.id);

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
          Text(Money.rsd(book.price) , style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700)),
          const SizedBox(height: 14,),
          Row(
            children: [
              IconButton(
                onPressed: ()=> context.read<WishlistProvider>().toggle(book.id), 
                icon: Icon(wished? Icons.favorite : Icons.favorite_border)
              ),
              const SizedBox(width: 8,),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: ()=> context.read<CartProvider>(). add(book), 
                  icon:  const Icon(Icons.add_shopping_cart_rounded),
                  label: const Text('Dodaj u korpu', style: TextStyle(fontSize: 15),)
                ),
              ),
            ],
          ),
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
          const SizedBox(height: 18,),
        ],
      ),
    );
  }
  
}