class OrderItem {
  final String bookId;
  final String title;
  final int price;
  final int qty;

  const OrderItem({
    required this.bookId,
    required this.title,
    required this.price,
    required this.qty,
  });

  int get subtotal => price * qty;

  Map<String, dynamic> toJson() => {
        'bookId': bookId,
        'title': title,
        'price': price,
        'qty': qty,
      };

  factory OrderItem.fromJson(Map<String, dynamic> j) => OrderItem(
        bookId: j['bookId'],
        title: j['title'],
        price: j['price'],
        qty: j['qty'],
      );
}

class Order {
  final String id;
  final DateTime createdAt;
  final List<OrderItem> items;
  final int total;
  final String status; 

  const Order({
    required this.id,
    required this.createdAt,
    required this.items,
    required this.total,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt.toIso8601String(),
        'items': items.map((e) => e.toJson()).toList(),
        'total': total,
        'status': status,
      };

  factory Order.fromJson(String id, Map<String, dynamic> j) => Order(
        id: id,
        createdAt: DateTime.parse(j['createdAt']),
        items: (j['items'] as List).map((e) => OrderItem.fromJson(e)).toList(),
        total: j['total'],
        status: j['status'],
      );
}
