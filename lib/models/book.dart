class Book {
  final String id;
  final String title;
  final String description;
  final int price;
  final String image;
  final String categoryId;
  final bool bestseller;

  const Book ({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.categoryId,
    required this.bestseller
  });

  factory Book.fromJson(Map<String, dynamic> j) => Book(
        id: j['id'],
        title: j['title'],
        image: j['image'],
        categoryId: j['categoryId'],
        description: j['description'],
        price: j['price'],
        bestseller: j['bestseller'] == false
      );
}