import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moj_projekat/models/user_role.dart';
import 'package:moj_projekat/providers/auth_provider.dart';
import 'package:moj_projekat/screens/admin_panel_screen.dart';
import 'package:moj_projekat/screens/book_details_screen.dart';
import 'package:moj_projekat/screens/category_books_screen.dart';
import 'package:moj_projekat/screens/login_screen.dart';
import 'package:moj_projekat/screens/register_screen.dart';
import 'package:moj_projekat/screens/root_screen.dart';
import 'package:moj_projekat/screens/splash_screen.dart';
import 'package:moj_projekat/screens/wishlist_screen.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static GoRouter create(){
    return GoRouter(
      initialLocation: SplashScreen.path,
      refreshListenable: _AuthRefresh(),
      routes: [
        GoRoute(
          path: SplashScreen.path,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: WishlistScreen.path,
          builder: (context, state) => const WishlistScreen(),
        ),
        GoRoute(
          path: LoginScreen.path,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: RegisterScreen.path,
          builder: (context, state) => const RegisterScreen(),
        ),
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
        ),
        GoRoute(
          path: AdminPanelScreen.path,
          builder: (context, state) => const AdminPanelScreen(),
        ),
      ],
      redirect: (ctx, st) {
        final auth = Provider.of<AuthProvider>(ctx, listen: false);
        final loc = st.matchedLocation;

        if (loc == SplashScreen.path) 
          return null;

        final logged = auth.isLoggedIn;
        final role = auth.role;

        if (loc == AdminPanelScreen.path && role != UserRole.admin) {
          return RootScreen.path;
        }
        if ((loc == LoginScreen.path || loc == RegisterScreen.path) && logged) {
          return RootScreen.path;
        }

        return null;
      }
    );
  }
}

class _AuthRefresh extends ChangeNotifier{
  _AuthRefresh();
}