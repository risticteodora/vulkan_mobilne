import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moj_projekat/providers/catalog_provider.dart';
import 'package:moj_projekat/providers/recently_viewed_provider.dart';
import 'package:provider/provider.dart';

class RecentlyViewedScreen extends StatelessWidget {
  static const path = '/recently-viewed';
  const RecentlyViewedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ids = context.watch<RecentlyViewedProvider>().bookIds;
    final catalog = context.watch<CatalogProvider>();

    final books = catalog.books.where((b) => ids.contains(b.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Poslednje pregledano'),
        actions: [
          IconButton(
            onPressed: () => context.read<RecentlyViewedProvider>().clear(),
            icon: const Icon(Icons.delete_outline),
          )
        ],
      ),
      body: ids.isEmpty
          ? const Center(child: Text('Još uvek nema pregledanih knjiga.'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: books.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final b = books[i];
                return ListTile(
                  leading: Image.asset(b.image, width: 50, fit: BoxFit.cover),
                  title: Text(b.title),
                  subtitle: Text('${b.price} RSD'),
                  onTap: () {
                    context.go('/book/${b.id}');
                  },
                );
              },
            ),
    );
  }
}
