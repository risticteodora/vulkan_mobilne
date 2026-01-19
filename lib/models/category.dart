class Category {
  final String id;
  final String name;
  final String iconAsset;

  const Category({
    required this.id,
    required this.name,
    required this.iconAsset
  });

  factory Category.fromJson(Map<String, dynamic> j) => Category(
        id: j['id'],
        name: j['name'],
        iconAsset: j['iconAsset'],
      );
}
