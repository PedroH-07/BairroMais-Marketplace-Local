class Product {
  final String id;
  final String name;
  final String unit; // ex: "Maço", "Bandeja 100g", "Unidade ~400g"
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.unit,
    required this.price,
    required this.imageUrl,
  });
}