import 'package:flutter/material.dart';

class QuantitySheet extends StatefulWidget{
  final int initial;
  final ValueChanged<int> onSelect;

  const QuantitySheet({
    super.key,
    required this.initial,
    required this.onSelect
  });
    
  @override
  State<StatefulWidget> createState() => _QuantitySheetState();
}
class _QuantitySheetState extends State<QuantitySheet>{
  late int qty;
  void initState(){
    super.initState();
    qty=widget.initial;
  }
  void _inc(){
    setState(() => qty++);
  }

  void _dec(){
    if(qty>1) {
      setState(() =>qty--);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10,),
          Container(height: 5,width: 48, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),),
          const SizedBox(height: 10,),
          const Text(
              'Količina',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _dec,
                  icon: const Icon(Icons.remove_circle_outline),
                  iconSize: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    qty.toString(),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: _inc,
                  icon: const Icon(Icons.add_circle_outline),
                  iconSize: 32,
                ),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onSelect(qty);
                  Navigator.pop(context);
                },
                child: const Text('Potvrdi'),
              ),
            )
          
        ],
      )
    );
  }
  
}