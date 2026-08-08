import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moj_projekat/providers/auth_provider.dart';
import 'package:moj_projekat/repositories/firebase/orders_repository.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const path = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (!auth.isLoggedIn || auth.session.uid == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Porudžbine')),
        body: const Center(child: Text('Uloguj se da vidiš porudžbine.')),
      );
    }

    final uid = auth.session.uid!;
    final repo = OrdersRepository();

    return Scaffold(
      appBar: AppBar(title: const Text('Porudžbine')),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: repo.streamOrdersForUser(uid),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Greška: ${snap.error}'));
          }

          final docs = snap.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(child: Text('Još uvek nema porudžbina.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, i) {
              final d = docs[i].data();
              final id = d['id']?.toString() ?? docs[i].id;
              final status = d['status']?.toString() ?? 'created';
              final total = d['total'] ?? 0;

              final createdAt = (d['createdAt'] is Timestamp)
                  ? (d['createdAt'] as Timestamp).toDate()
                  : null;

              final items = (d['items'] as List? ?? []).cast<Map>();

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Porudžbina #$id',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 6),
                      Text('Status: $status'),
                      Text('Datum: ${createdAt ?? '—'}'),
                      const Divider(),
                      ...items.map((it) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Expanded(child: Text(it['title']?.toString() ?? '')),
                                Text('x${it['qty'] ?? 0}'),
                                const SizedBox(width: 12),
                                Text('${(it['price'] ?? 0) * (it['qty'] ?? 0)} RSD'),
                              ],
                            ),
                          )),
                      const Divider(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('Ukupno: $total RSD',
                            style: Theme.of(context).textTheme.titleSmall),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
