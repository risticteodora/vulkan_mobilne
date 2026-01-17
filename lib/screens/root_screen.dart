import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
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
        destinations: const[
          NavigationDestination(icon: Icon(IconlyLight.home),selectedIcon: Icon(IconlyBold.home) ,label: 'Home'),
          NavigationDestination(icon: Icon(IconlyLight.search),selectedIcon: Icon(IconlyBold.search) ,label: 'Search'),
          NavigationDestination(icon: Icon(IconlyLight.bag),selectedIcon: Icon(IconlyBold.bag) ,label: 'Cart'),
          NavigationDestination(icon: Icon(IconlyLight.profile),selectedIcon: Icon(IconlyBold.profile) ,label: 'Profile')
        ],
      ),
    );
  }

}
  
