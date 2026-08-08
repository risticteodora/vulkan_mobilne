import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moj_projekat/providers/cart_provider.dart';
import 'package:moj_projekat/screens/payment_screen.dart';
import 'package:moj_projekat/util/money.dart';
import 'package:moj_projekat/widgets/cart_item_tile.dart';
import 'package:moj_projekat/widgets/empty_state.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Korpa (${cart.totalItems})'),
        actions: [
          IconButton(
            onPressed: cart.items.isEmpty ? null : cart.clear,
            icon: const Icon(Icons.delete_forever_rounded),
          ),
        ],
      ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Ukupno: ${Money.rsd(cart.total)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => context.push(PaymentScreen.path),
                    child: const Text('Plaćanje'),
                  ),
                ],
              ),
            ),
      body: cart.items.isEmpty
          ? const EmptyState(
              title: 'Korpa je prazna',
              subtitle: 'Dodaj knjige sa početne strane ili pronađi traženu knjigu',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: cart.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) => CartItemTile(item: cart.items[index]),
            ),
    );
  }
}
