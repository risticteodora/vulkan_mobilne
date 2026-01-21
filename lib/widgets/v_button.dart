import 'package:flutter/material.dart';

class VButton extends StatelessWidget{
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  const VButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon
  });
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed, 
        icon: Icon(icon ?? Icons.check),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(label),
        )
      ),
    );
  }

  
}