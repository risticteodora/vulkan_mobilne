import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget{
  final String assetPath;
  final VoidCallback? onTap;

  const HomeBanner({
    super.key,
    required this.assetPath,
    this.onTap
  });
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: 1/1,
          child: Image.asset(
            assetPath,
            width: double.infinity,
            fit: BoxFit.cover,
          ),  
        ),
      ),
    );
  }

  
}