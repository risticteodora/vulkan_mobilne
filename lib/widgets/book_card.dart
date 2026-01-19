import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moj_projekat/models/book.dart';
import 'package:moj_projekat/screens/book_details_screen.dart';
import 'package:moj_projekat/widgets/subtitle_text.dart';
import 'package:moj_projekat/widgets/title_text.dart';

class BookCard extends StatelessWidget {
  final Book book;
  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('${BookDetailsScreen.path}?id=${book.id}'),
      borderRadius: BorderRadius.circular(2),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 3/4,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  book.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TitlesTextWidget(
                label: book.title,
                fontSize: 15,
                maxLines: 2,
              ),
            ),

            const SizedBox(height: 6),
            SubtitleTextWidget(
              label: '${book.price} RSD',
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
