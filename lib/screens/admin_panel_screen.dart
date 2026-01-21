import 'package:flutter/material.dart';

class AdminPanelScreen extends StatelessWidget{
  static const path = '/admin';
  const AdminPanelScreen({
    super.key
  });
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin panel'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Knjige',),
              Tab(text: 'Korisnici',),
              Tab(text: 'Porudžbine',)
            ]
          ),
        ),
        body: const TabBarView(
          children: [
            _AdminBooksTab(),
            _AdminUsersTab(),
            _AdminOrdersTab()
          ]
        ),
      )
    );
  }
}

class _AdminBooksTab extends StatelessWidget{
  const _AdminBooksTab();
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        ListTile(
          leading: Icon(Icons.add),
          title: Text('Dodaj knjigu'),
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Izmeni knjigu'),
        ),
        ListTile(
          leading: Icon(Icons.delete),
          title: Text('Obriši knjigu'),
        )
      ],
    );
  }
  
}

class _AdminUsersTab extends StatelessWidget{
  const _AdminUsersTab();
  
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Upravljanje korisnicima'),);
  }
  
}

class _AdminOrdersTab extends StatelessWidget{
  const _AdminOrdersTab();
  
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Upravljanje porudžbinama'),);
  }

}