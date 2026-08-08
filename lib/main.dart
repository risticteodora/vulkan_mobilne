import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moj_projekat/consts/theme.dart';
import 'package:moj_projekat/firebase_options.dart';
import 'package:moj_projekat/providers/auth_provider.dart';
import 'package:moj_projekat/providers/cart_provider.dart';
import 'package:moj_projekat/providers/catalog_provider.dart';
import 'package:moj_projekat/providers/orders_provider.dart';
import 'package:moj_projekat/providers/recently_viewed_provider.dart';
import 'package:moj_projekat/providers/theme_provider.dart';
import 'package:moj_projekat/providers/wishlist_provider.dart';
import 'package:moj_projekat/repositories/firebase/firebase_auth_repository.dart';
import 'package:moj_projekat/repositories/firebase/firebase_book_repository.dart';
import 'package:moj_projekat/repositories/firebase/recently_viewed_repository.dart';
import 'package:moj_projekat/repositories/firebase/wishlist_repository.dart';
import 'package:moj_projekat/router/app_router.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Nateraj Flutter da ispiše čitljivu grešku u pregledaču umesto minifikovanog aYT
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    print("FLUTTER_ERROR: ${details.exception}");
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    print("PLATFORM_ERROR: $error");
    return true;
  };

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kIsWeb) {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: false,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthProvider _auth;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _auth = AuthProvider(FirebaseAuthRepository())..init();
    _router = AppRouter.create(_auth);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: _auth),
        ChangeNotifierProvider(
          create: (_) => CatalogProvider(FirebaseBookRepository()),
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProxyProvider<AuthProvider, WishlistProvider>(
          create: (_) => WishlistProvider(WishlistRepository()),
          update: (_, auth, wishlist) {
            final uid = (auth.isLoggedIn && auth.session != null)
                ? auth.session.uid
                : null;
            final target = wishlist ?? WishlistProvider(WishlistRepository());
            target.setUser(uid);
            return target;
          },
        ),
        ChangeNotifierProxyProvider<AuthProvider, RecentlyViewedProvider>(
          create: (_) => RecentlyViewedProvider(RecentlyViewedRepository()),
          update: (_, auth, recent) {
            final uid = (auth.isLoggedIn && auth.session != null)
                ? auth.session.uid
                : null;
            final target =
                recent ?? RecentlyViewedProvider(RecentlyViewedRepository());
            target.setUser(uid);
            return target;
          },
        ),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp.router(
            title: 'Vulkan',
            theme: Style.light(),
            darkTheme: Style.dark(),
            themeMode: ThemeMode.system,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}