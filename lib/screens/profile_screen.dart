import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moj_projekat/models/user_role.dart';
import 'package:moj_projekat/providers/auth_provider.dart';
import 'package:moj_projekat/screens/admin_panel_screen.dart';
import 'package:moj_projekat/screens/login_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    //final themeProvider= Provider.of<ThemeProvider>(context);
    final auth =Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"), 
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person_2_rounded),),
              title: Text(auth.isLoggedIn ? (auth.session.displayName ?? 'Korisnik') : 'Gost'),
              subtitle: Text(auth.isLoggedIn ? (auth.session.email ?? ''): 'Korisnik nije ulogovan'),
              trailing: auth.isLoggedIn ? Text(auth.role == UserRole.admin ? 'Admin' : 'User') : const Text('Guest'),
              ),
          ),
          const SizedBox(height: 12,),
          if(!auth.isLoggedIn)
            ElevatedButton.icon(
              onPressed: ()=> context.go(LoginScreen.path), 
              icon:  const Icon(Icons.login),
              label: const Text('Login')
            )
          else
            ElevatedButton.icon(
              onPressed: ()=> context.read<AuthProvider>().logout(), 
              icon:  const Icon(Icons.logout),
              label: const Text('Logout')
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
          if(auth.role ==UserRole.admin)...[
            const Divider(),
              ListTile(
                leading: const Icon(Icons.admin_panel_settings),
                title: const Text('Admin panel'),
                onTap: () => context.push(AdminPanelScreen.path),
              )
          ]
        ],
      ),
    );
  }
}