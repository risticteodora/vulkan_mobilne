import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String iconLight;
  final String iconDark;

  const Category({
    required this.id,
    required this.name,
    required this.iconLight,
    required this.iconDark
  });

  String iconFor(BuildContext context){
    final isDark= Theme.of(context).brightness == Brightness.dark;
    return isDark? iconDark : iconLight;
  }

  factory Category.fromJson(Map<String, dynamic> j) => Category(
        id: j['id'],
        name: j['name'],
        iconLight: j['iconLight'],
        iconDark: j['iconDark']
      );
}
