import 'package:go_router/go_router.dart';
import 'package:moj_projekat/screens/book_details_screen.dart';
import 'package:moj_projekat/screens/category_books_screen.dart';
import 'package:moj_projekat/screens/root_screen.dart';

class AppRouter {
  static GoRouter create(){
    return GoRouter(
      routes: [
        GoRoute(
          path: RootScreen.path,
          builder: (context, state) => const RootScreen(),
        ),
        GoRoute(
          path: BookDetailsScreen.path,
          builder: (context, state) {
            final id=state.uri.queryParameters['id'] ?? '';
            return BookDetailsScreen(bookId: id);
          },
        ),
        GoRoute(
          path: CategoryBooksScreen.path,
          builder: (context, state) {
            final id= state.uri.queryParameters['id'] ;
            final name= state.uri.queryParameters['name'] ?? 'Kategorija';
            return CategoryBooksScreen(categoryId: id, categoryName: name);
          },
        )
      ]
    );
  }
}