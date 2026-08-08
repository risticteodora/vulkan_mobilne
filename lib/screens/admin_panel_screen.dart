import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moj_projekat/models/book.dart';
import 'package:moj_projekat/repositories/firebase/admin_books_repository.dart';
import 'package:moj_projekat/repositories/firebase/admin_users_repository.dart';
import 'package:moj_projekat/repositories/firebase/orders_repository.dart';

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


class _AdminBooksTab extends StatelessWidget {
  const _AdminBooksTab();

  @override
  Widget build(BuildContext context) {
    
    final repo = AdminBooksRepository();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: FilledButton.icon(
            onPressed: () => _openBookDialog(context, repo),
            icon: const Icon(Icons.add),
            label: const Text('Dodaj knjigu'),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: repo.streamBooks(),
            builder: (context, snap) {
              if (snap.hasError) {
                return Center(child: Text('Greška: ${snap.error}'));
              }
              if (!snap.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final books = snap.data!;
              if (books.isEmpty) {
                return const Center(child: Text('Nema knjiga.'));
              }

              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: books.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, i) {
                  final b = books[i];
                  return Card(
                    child: ListTile(
                      title: Text(b.title),
                      subtitle: Text('${b.price} RSD • ${b.categoryId}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _openBookDialog(context, repo, book: b),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              final ok = await showDialog<bool>(
                                context: context,
                                builder: (dialogCtx) => AlertDialog(
                                  title: const Text('Brisanje'),
                                  content: Text('Obrisati "${b.title}"?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(dialogCtx, false),
                                      child: const Text('Ne'),
                                    ),
                                    FilledButton(
                                      onPressed: () => Navigator.pop(dialogCtx, true),
                                      child: const Text('Da'),
                                    ),
                                  ],
                                ),
                              );

                              if (ok == true) {
                                await repo.deleteBook(b.id);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

  Future<void> _openBookDialog(BuildContext context, AdminBooksRepository repo, {Book? book}) async {
  final isEdit = book != null;

  final formKey = GlobalKey<FormState>();

  final idCtrl = TextEditingController(text: book?.id ?? '');
  final titleCtrl = TextEditingController(text: book?.title ?? '');
  final descCtrl = TextEditingController(text: book?.description ?? '');
  final priceCtrl = TextEditingController(text: book?.price.toString() ?? '');
  final imageCtrl = TextEditingController(text: book?.image ?? '');
  String categoryId = book?.categoryId ?? '';
  bool bestseller = book?.bestseller ?? false;

  final categoriesSnap = await FirebaseFirestore.instance
      .collection('categories')
      .orderBy('order')
      .get();
  final categories = categoriesSnap.docs
      .map((d) => {'id': d.id, 'name': (d.data()['name'] ?? d.id).toString()})
      .toList();

  if (categoryId.isEmpty && categories.isNotEmpty) {
    categoryId = categories.first['id']!;
  }

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => StatefulBuilder(
      builder: (context, setSt) {
        final imagePath = imageCtrl.text.trim();

        return AlertDialog(
          title: Row(
            children: [
              Icon(isEdit ? Icons.edit : Icons.menu_book),
              const SizedBox(width: 8),
              Text(isEdit ? 'Izmeni knjigu' : 'Dodaj knjigu'),
            ],
          ),
          content: SizedBox(
            width: 420, 
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                   
                    if (imagePath.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          imagePath,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 120,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: const Text('Nije pronađena slika (asset)'),
                          ),
                        ),
                      ),
                    if (imagePath.isNotEmpty) const SizedBox(height: 12),

                    if (!isEdit)
                      TextFormField(
                        controller: idCtrl,
                        decoration: const InputDecoration(
                          labelText: 'ID',
                          hintText: 'npr. book_1',
                          prefixIcon: Icon(Icons.tag),
                        ),
                        validator: (v) {
                          final s = (v ?? '').trim();
                          if (s.isEmpty) return 'Unesi ID';
                          if (s.contains('/')) return 'ID ne sme da sadrži "/"';
                          return null;
                        },
                      ),
                    if (!isEdit) const SizedBox(height: 12),

                    TextFormField(
                      controller: titleCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Naslov',
                        prefixIcon: Icon(Icons.title),
                      ),
                      validator: (v) =>
                          (v ?? '').trim().isEmpty ? 'Unesi naslov' : null,
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: descCtrl,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Opis',
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.description),
                      ),
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: priceCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Cena (RSD)',
                        prefixIcon: Icon(Icons.payments),
                      ),
                      validator: (v) {
                        final p = int.tryParse((v ?? '').trim());
                        if (p == null || p <= 0) return 'Unesi cenu > 0';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: imageCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Slika (asset path)',
                        hintText: 'assets/images/...',
                        prefixIcon: Icon(Icons.image),
                      ),
                      onChanged: (_) => setSt(() {}),
                    ),
                    const SizedBox(height: 12),

                    DropdownButtonFormField<String>(
                      value: categoryId.isEmpty ? null : categoryId,
                      items: categories
                          .map((c) => DropdownMenuItem(
                                value: c['id'],
                                child: Text(c['name']!),
                              ))
                          .toList(),
                      onChanged: (v) => setSt(() => categoryId = v ?? ''),
                      decoration: const InputDecoration(
                        labelText: 'Kategorija',
                        prefixIcon: Icon(Icons.category),
                      ),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Izaberi kategoriju' : null,
                    ),
                    const SizedBox(height: 8),

                    SwitchListTile(
                      value: bestseller,
                      onChanged: (v) => setSt(() => bestseller = v),
                      title: const Text('Bestseller'),
                      subtitle: const Text('Prikaži u “Bestseller” sekciji'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Otkaži'),
            ),
            FilledButton.icon(
              icon: const Icon(Icons.save),
              label: Text(isEdit ? 'Sačuvaj' : 'Dodaj'),
              onPressed: () async {
                if (!(formKey.currentState?.validate() ?? false)) return;

                final id = isEdit ? book.id : idCtrl.text.trim();
                final price = int.parse(priceCtrl.text.trim());

                final b = Book(
                  id: id,
                  title: titleCtrl.text.trim(),
                  description: descCtrl.text.trim(),
                  price: price,
                  image: imageCtrl.text.trim(),
                  categoryId: categoryId.trim(),
                  bestseller: bestseller,
                );

                try {
                  if (isEdit) {
                    await repo.updateBook(b);
                  } else {
                    await repo.createBook(b);
                  }

                  if (!context.mounted) return;
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sačuvano ✅')),
                  );
                } catch (e) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Greška pri upisu: $e')),
                  );
                }
              },
            ),
          ],
        );
      },
    ),
  );
}

class _AdminUsersTab extends StatelessWidget {
  const _AdminUsersTab();

  @override
  Widget build(BuildContext context) {
    final repo = AdminUsersRepository();

    return StreamBuilder(
      stream: repo.streamUsers(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snap.data!.docs;

        if (docs.isEmpty) return const Center(child: Text('Nema korisnika.'));

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: docs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final d = docs[i];
            final data = d.data();
            final uid = d.id;
            final email = data['email'] ?? '';
            final name = data['displayName'] ?? '';
            final role = (data['role'] ?? 'user').toString();

            return Card(
              child: ListTile(
                title: Text(name.toString().isEmpty ? email : '$name'),
                subtitle: Text(email),
                trailing: DropdownButton<String>(
                  value: role,
                  items: const [
                    DropdownMenuItem(value: 'user', child: Text('user')),
                    DropdownMenuItem(value: 'admin', child: Text('admin')),
                  ],
                  onChanged: (v) async {
                    if (v == null) return;
                    await repo.setRole(uid, v);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Role za $email je sada: $v')),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}


class _AdminOrdersTab extends StatelessWidget {
  const _AdminOrdersTab();

  @override
  Widget build(BuildContext context) {
    final repo = OrdersRepository();

    return StreamBuilder(
      stream: repo.streamAllOrders(),
      builder: (context, snap) {
        if (!snap.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snap.data!.docs;
        if (docs.isEmpty) return const Center(child: Text('Nema porudžbina.'));

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: docs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final d = docs[i];
            final data = d.data();
            final id = d.id;
            final userId = data['userId'] ?? '';
            final total = data['total'] ?? 0;
            final status = (data['status'] ?? 'created').toString();

            return Card(
              child: ListTile(
                title: Text('Order $id • ${total} RSD'),
                subtitle: Text('User: $userId'),
                trailing: DropdownButton<String>(
                  value: status,
                  items: const [
                    DropdownMenuItem(value: 'created', child: Text('Napravljena')),
                    DropdownMenuItem(value: 'paid', child: Text('Plaćeno')),
                    DropdownMenuItem(value: 'shipped', child: Text('Poslato')),
                    DropdownMenuItem(value: 'delivered', child: Text('Isporučeno')),
                    DropdownMenuItem(value: 'cancelled', child: Text('Otkazano')),
                  ],
                  onChanged: (v) async {
                    if (v == null) return;
                    await repo.updateStatus(id, v);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Status porudžbine $id: $v')),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
