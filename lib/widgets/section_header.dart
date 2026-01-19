import 'package:flutter/material.dart';
import 'package:moj_projekat/widgets/title_text.dart';

class SectionHeader extends StatelessWidget{
  final String title;
  final double fontSize;
  const SectionHeader({
    super.key,
    required this.title,
    required this.fontSize
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitlesTextWidget( fontSize: fontSize, label: title,)
      ],
    );
  }

  
}