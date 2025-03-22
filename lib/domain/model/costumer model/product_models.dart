class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final Map<String, double> prices; // ✅ Stores prices dynamically
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.prices,  // ✅ Uses a map for different sizes
    required this.category,
  });

  double getPrice(String size) {
    return prices[size] ?? prices['S']!; // ✅ Default to small price if size not found
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      prices: {
        'S': (json['priceS'] as num).toDouble(),
        'M': (json['priceM'] as num).toDouble(),
        'L': (json['priceL'] as num).toDouble(),
      },
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'priceS': prices['S'],
      'priceM': prices['M'],
      'priceL': prices['L'],
      'category': category,
    };
  }
}
