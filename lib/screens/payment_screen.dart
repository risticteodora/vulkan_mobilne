import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moj_projekat/providers/auth_provider.dart';
import 'package:moj_projekat/providers/cart_provider.dart';
import 'package:moj_projekat/repositories/firebase/orders_repository.dart';
import 'package:moj_projekat/screens/orders_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class PaymentScreen extends StatefulWidget {
  static const path = '/payment';
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _loading = false;
  Future<void> _openStripe() async {
    final uri = Uri.parse('https://buy.stripe.com/test_fZu3cveNi0Ho70f1h24Rq00'); 
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) {
      throw Exception('Ne mogu da otvorim Stripe checkout');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Plaćanje')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('Ukupno'),
                subtitle: const Text('Pregled porudžbine'),
                trailing: Text('${cart.total} RSD'),
              ),
            ),
            const SizedBox(height: 12),
            const Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.payments_outlined),
                    title: Text('Način plaćanja'),
                    subtitle: Text('Dostupno je samo online plaćanje'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.local_shipping_outlined),
                    title: Text('Dostava'),
                    subtitle: Text('Standardna dostava u roku od 5-7 radnih dana'),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: cart.items.isEmpty || _loading
                    ? null
                    : () async {
                        setState(() => _loading = true);

                        final auth = context.read<AuthProvider>();
                        if (!auth.isLoggedIn || auth.session.uid == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Moraš da se uloguješ da bi poručila.'),
                            ),
                          );
                          setState(() => _loading = false);
                          return;
                        }

                        await _openStripe(); 

                        final uid = auth.session.uid!;
                        final repo = OrdersRepository();

                        final items = cart.items
                            .map((it) => {
                                  'bookId': it.book.id,
                                  'title': it.book.title,
                                  'price': it.book.price,
                                  'qty': it.qty,
                                  'image': it.book.image,
                                })
                            .toList();

                        try {
                          await repo.createOrder(
                            userId: uid,
                            items: items,
                            total: cart.total,
                          );

                          cart.clear();

                          if (!mounted) return;
                          setState(() => _loading = false);
                          context.push(OrdersScreen.path);
                        } catch (e) {
                          if (!mounted) return;
                          setState(() => _loading = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Greška: $e')),
                          );
                        }
                      },
                child: _loading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Plati karticom'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
