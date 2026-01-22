import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moj_projekat/providers/catalog_provider.dart';
import 'package:moj_projekat/screens/category_books_screen.dart';
import 'package:moj_projekat/widgets/book_card.dart';
import 'package:moj_projekat/widgets/category_round.dart';
import 'package:moj_projekat/widgets/empty_state.dart';
import 'package:moj_projekat/widgets/home_banner.dart';
import 'package:moj_projekat/widgets/section_header.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog=context.watch<CatalogProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logo.jpg',
            height: 40,
          ),
          const SizedBox(width: 2),
          Text(
            'Vulkan knjižara',
            style: GoogleFonts.lora(fontSize: 32, fontWeight: FontWeight.w500, color:Theme.of(context).colorScheme.onSurface),
          ),
          ],
        ),
      ),
      body: catalog.loading ? 
        const Center(child: CircularProgressIndicator(),) : catalog.books.isEmpty? 
          const EmptyState(
            title:"Nema trenutno dostupnih knjiga", subtitle: '',
          ) :
          ListView(
            padding: const EdgeInsets.all(12),
            children: [
              HomeBanner(
                assetPath: 'assets/images/prviBaner.jpg',
                onTap: (){

                },
              ),
              const SizedBox(height: 8,),
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1)),
                  SectionHeader(title: "Najnoviji naslovi u Vulkanu", fontSize: 20),
                  SizedBox(width: 12),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 8,),
              SizedBox(
                height: 310,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: catalog.latest.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 5,),
                  itemBuilder: (context,i) =>SizedBox(
                    width: 160,
                    child: BookCard(book: catalog.latest[i]),
                ),
              ),),
              const SizedBox(height: 8,),
                HomeBanner(
                assetPath: 'assets/images/197106020161fd01ed30952566527999_640.png',
                onTap: (){

                },
              ),
              const SizedBox(height: 18,),
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1)),
                  SizedBox(width: 12),
                  SectionHeader(title: "Kategorije", fontSize: 18),
                  SizedBox(width: 12),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 8,),
              GridView.builder(
                shrinkWrap: true, 
                physics: const NeverScrollableScrollPhysics(),
                itemCount: catalog.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10 
                ),
                itemBuilder: (context,i){
                  final c=catalog.categories[i];
                  final isDark = Theme.of(context).brightness ==Brightness.dark;
                  return CategoryRound(
                    iconAsset: isDark ? c.iconDark : c.iconLight,
                    name: c.name,
                    onTap: (){
                      context.push('${CategoryBooksScreen.path}?id=${c.id}&name=${Uri.encodeComponent(c.name)}');
                    },
                  );
                },
                ),
                const SizedBox(height: 12,),
                Row(
                children: const [
                  Expanded(child: Divider(thickness: 1)),
                  SizedBox(width: 12),
                  SectionHeader(title: "Aktuelna ponuda", fontSize: 22),
                  SizedBox(width: 12),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
                const SizedBox(height: 8,),
                GridView.builder(
                  shrinkWrap: true, 
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: catalog.books.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.55
                  ),
                  itemBuilder: (_, index) => BookCard(book: catalog.books[index]),
                ),
            ],
          )
    );
  }
}