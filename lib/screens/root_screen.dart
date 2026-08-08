import 'package:flutter/material.dart';
import 'package:moj_projekat/screens/cart_screen.dart';
import 'package:moj_projekat/screens/home_screen.dart';
import 'package:moj_projekat/screens/profile_screen.dart';
import 'package:moj_projekat/screens/search_screen.dart';

class RootScreen extends StatefulWidget{
  static const path ='/';
  const RootScreen({super.key});
  
  @override
  State<RootScreen> createState()=> _RootScreen();
}

class _RootScreen extends State<RootScreen>{
  int idx=0;

  final screens= const[
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[idx],
      bottomNavigationBar: NavigationBar(
        selectedIndex: idx,
        onDestinationSelected: (value) => setState(() =>idx =value ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Početna',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Pretraga',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag),
            label: 'Korpa',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],

      ),
    );
  }

}
  
