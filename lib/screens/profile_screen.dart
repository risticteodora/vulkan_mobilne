import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    //final themeProvider= Provider.of<ThemeProvider>(context);
    //final auth =Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"), 
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person_2_rounded),)
              
              ),
          ),
          const SizedBox(height: 12,),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text("Lista želja"),
            //onTap: () => context.push(WishlistScreen.path),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Poslednje pregledano"),
            //onTap: () => context.push(ViewedRecentlyScreen.path),
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text("Porudžbine"),
            //onTap: () => context.push(OrdersScreen.path),
          ),
        ],
      ),
    );
  }
}