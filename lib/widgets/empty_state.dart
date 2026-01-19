import 'package:flutter/material.dart';
import 'package:moj_projekat/widgets/subtitle_text.dart';
import 'package:moj_projekat/widgets/title_text.dart';

class EmptyState extends StatelessWidget{
  final String title;
  final String subtitle;
  final String? asset;
  final String? actionText;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    this.asset,
    this.actionText,
    this.onAction
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(asset!=null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Image.asset(asset!, height: 120,),
              ),
            TitlesTextWidget(label:title, fontSize: 20,),
            const SizedBox(height: 8,),
            SubtitleTextWidget(label: subtitle, fontSize: 14),
            if(actionText!=null) ...[
              const SizedBox(height: 14,),
              ElevatedButton(onPressed: onAction, child: Text(actionText!)),
            ]
          ],
        ),
        ),
    );
  }

  
}