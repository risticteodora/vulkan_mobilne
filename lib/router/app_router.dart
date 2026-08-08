//import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:moj_projekat/models/user_role.dart';
import 'package:moj_projekat/providers/auth_provider.dart';
import 'package:moj_projekat/screens/admin_panel_screen.dart';
import 'package:moj_projekat/screens/book_details_screen.dart';
import 'package:moj_projekat/screens/category_books_screen.dart';
import 'package:moj_projekat/screens/login_screen.dart';
import 'package:moj_projekat/screens/orders_screen.dart';
import 'package:moj_projekat/screens/payment_screen.dart';
import 'package:moj_projekat/screens/recently_viewd_screen.dart';
import 'package:moj_projekat/screens/register_screen.dart';
import 'package:moj_projekat/screens/root_screen.dart';
import 'package:moj_projekat/screens/splash_screen.dart';
import 'package:moj_projekat/screens/wishlist_screen.dart';
//import 'package:provider/provider.dart';

class AppRouter {
  static GoRouter create(AuthProvider auth){
    return GoRouter(
      refreshListenable: auth,
      initialLocation: SplashScreen.path,
      redirect: (context, state) {
        final loggedIn = auth.isLoggedIn;
        final loc = state.matchedLocation;

        const protected = <String>{
          AdminPanelScreen.path,
          OrdersScreen.path,   
        };

        final goingToProtected = protected.contains(loc);

        if (!loggedIn && goingToProtected) {
          return LoginScreen.path;
        }

        if (loggedIn && (loc == LoginScreen.path || loc == RegisterScreen.path)) {
          return RootScreen.path;
        }

        return null;
      },
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
        GoRoute(
          path: PaymentScreen.path,
          builder: (_, __) => const PaymentScreen(),
        ),
        GoRoute(
          path: OrdersScreen.path,
          builder: (_, __) => const OrdersScreen(),
        ),
        GoRoute(
          path: RecentlyViewedScreen.path,
          builder: (_, __) => const RecentlyViewedScreen(),
        ),

      ],
    );
  }
}

/*class _AuthRefresh extends ChangeNotifier{
  _AuthRefresh();
}*/