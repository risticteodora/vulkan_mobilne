import 'package:flutter/material.dart';
import 'package:moj_projekat/providers/catalog_provider.dart';
import 'package:moj_projekat/widgets/book_card.dart';
import 'package:moj_projekat/widgets/empty_state.dart';
import 'package:moj_projekat/widgets/title_text.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget{
  const SearchScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Pretraga"),),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Pretrazi po nazivu',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: catalog.query.isEmpty? null : IconButton(
                  onPressed: ()=>context.read<CatalogProvider>().setQuery(''), 
                  icon: const Icon(Icons.clear_rounded)
                )
              ),
              onChanged: (v)=> context.read<CatalogProvider>().setQuery(v),
            ),
            const SizedBox(height: 12,),
            Expanded(
              child: catalog.filtered.isEmpty ? 
                const EmptyState(title: "Nema rezultata", subtitle: "Probajte ponovo") : 
                GridView.builder(
                  itemCount: catalog.filtered.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.55
                  ), 
                  itemBuilder: (context,i)=> BookCard(book: catalog.filtered[i])
                )
            )
          ],
        ),
      ),
    );
  }

  
}