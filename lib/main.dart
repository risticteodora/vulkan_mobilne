import 'package:firebase_core/firebase_core.dart';
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
//import 'package:moj_projekat/repositories/mock/mock_auth_repository.dart';
//import 'package:moj_projekat/repositories/mock/mock_book_repository.dart';
import 'package:moj_projekat/router/app_router.dart';
//import 'package:moj_projekat/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  /*// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) { return ThemeProvider();}),
        ChangeNotifierProvider(create: (_) => AuthProvider(FirebaseAuthRepository())..init()),
        ChangeNotifierProvider(create: (_) => CatalogProvider(FirebaseBookRepository())),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        //ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProxyProvider<AuthProvider, WishlistProvider>(
          create: (_) => WishlistProvider(),
          update: (_, auth, wishlist) {
            final uid = auth.isLoggedIn ? auth.session.uid : null;
            wishlist!.setUser(uid);
            return wishlist;
          },
        ),


        //ChangeNotifierProvider(create: (_) => RecentlyViewedProvider()),
        ChangeNotifierProxyProvider<AuthProvider, RecentlyViewedProvider>(
          create: (_) => RecentlyViewedProvider(RecentlyViewedRepository()),
          update: (_, auth, recent) {
            final uid = auth.isLoggedIn ? auth.session.uid : null;
    
            recent!.setUser(uid);
            return recent;
          },    
        ),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
      ],
      child: Consumer2<ThemeProvider, AuthProvider>(builder: (context, themeProvider,auth, child) {
        return MaterialApp.router(
          title: 'Vulkan',
          theme:Style.light(),
          darkTheme: Style.dark(),
          themeMode: ThemeMode.system,
          routerConfig: AppRouter.create(auth)
        );
      }),
    );
  }
}*/
@override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: _auth), 
        ChangeNotifierProvider(create: (_) => CatalogProvider(FirebaseBookRepository())),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProxyProvider<AuthProvider, WishlistProvider>(
          create: (_) => WishlistProvider(WishlistRepository()),
          update: (_, auth, wishlist) {
            final uid = auth.isLoggedIn ? auth.session.uid : null;
            wishlist!.setUser(uid);
            return wishlist;
          },
        ),

        ChangeNotifierProxyProvider<AuthProvider, RecentlyViewedProvider>(
          create: (_) => RecentlyViewedProvider(RecentlyViewedRepository()),
          update: (_, auth, recent) {
            final uid = auth.isLoggedIn ? auth.session.uid : null;
            recent!.setUser(uid);
            return recent;
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

