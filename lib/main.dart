import 'package:flutter/material.dart';
import 'package:moj_projekat/consts/theme.dart';
import 'package:moj_projekat/providers/theme_provider.dart';
import 'package:moj_projekat/screens/root_screen.dart';
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
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Vulkan',
          theme: themeProvider.isDarkTheme ? Style.dark(): Style.light(),
          home: const RootScreen(),
        );
      }),
    );
  }
}

