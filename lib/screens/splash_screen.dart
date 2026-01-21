import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moj_projekat/providers/catalog_provider.dart';
import 'package:moj_projekat/screens/root_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget{
  static const path ='/splash';
  const SplashScreen({
    super.key
  });
  
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
  
}

class _SplashScreenState extends State<SplashScreen>{

  void initState(){
    super.initState();
    _boot();
  }

  Future<void> _boot() async {
    final catalog= context.read<CatalogProvider>();

    await Future.wait([
    catalog.load(),
    Future.delayed(const Duration(seconds: 1)), 
  ]);


    if(!mounted)
      return;
    context.go(RootScreen.path);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.jpg', height: 80,),
            const SizedBox(height: 20,),
            const CircularProgressIndicator()
          ],
        )
      ),
    );
  }
  
}