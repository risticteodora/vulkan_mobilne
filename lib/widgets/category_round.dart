import 'package:flutter/material.dart';
import 'package:moj_projekat/widgets/subtitle_text.dart';

class CategoryRound extends StatelessWidget{
  //final String iconAsset;
  final String name;
  final VoidCallback onTap;

  const CategoryRound({
    super.key,
    //required this.iconAsset,
    required this.name,
    required this.onTap
  });
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.category,size: 40,),
          const SizedBox(height: 6,),
          SubtitleTextWidget(label: name, fontSize: 12, fontWeight: FontWeight.w600,)
        ],
      ),
    );
  }

  
}