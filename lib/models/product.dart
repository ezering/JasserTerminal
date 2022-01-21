class Product {
  final String id;
  final String name;
  final String description;
  final String quantity;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'price': price,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
