import 'package:flutter/material.dart';
import 'package:moj_projekat/models/cart_item.dart';
import 'package:moj_projekat/providers/cart_provider.dart';
import 'package:moj_projekat/util/money.dart';
import 'package:moj_projekat/widgets/quantity_sheet.dart';
import 'package:provider/provider.dart';

class CartItemTile extends StatelessWidget{
  final CartItem item;
  const CartItemTile({
    super.key,
    required this.item
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(item.book.image, width: 55, height: 55, fit: BoxFit.cover),
        ),
        title: Text(item.book.title, maxLines: 2,overflow: TextOverflow.ellipsis,),
        subtitle: Text('${Money.rsd(item.book.price)} • Količina: ${item.qty}'),
        trailing: Wrap(
          spacing: 4,
          children: [
            IconButton(
              onPressed: () async{
                await showModalBottomSheet(
                  context: context, 
                  builder: (_)=> QuantitySheet(
                    initial: item.qty,
                    onSelect: (q)=> context.read<CartProvider>().setQty(item.book.id,q)
                  )
                );
              }, 
              icon: Icon(Icons.expand_more_rounded)
            ),
            IconButton(
              onPressed: ()=> context.read<CartProvider>().remove(item.book.id), 
              icon: Icon(Icons.delete_outline)
            )
          ],
        ),
      ),
    );
  }

  
}