import 'package:flutter/material.dart';
import 'package:moj_projekat/consts/theme.dart';
import 'package:moj_projekat/providers/cart_provider.dart';
import 'package:moj_projekat/providers/catalog_provider.dart';
import 'package:moj_projekat/providers/theme_provider.dart';
import 'package:moj_projekat/repositories/mock/mock_book_repository.dart';
import 'package:moj_projekat/router/app_router.dart';
//import 'package:moj_projekat/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) { return ThemeProvider();}),
        ChangeNotifierProvider(create: (_) => CatalogProvider(MockBookRepository())..load()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp.router(
          title: 'Vulkan',
          theme:Style.light(),
          darkTheme: Style.dark(),
          themeMode: ThemeMode.system,
          routerConfig: AppRouter.create()
        );
      }),
    );
  }
}

