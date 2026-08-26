import 'product_model.dart';

class Store {
  final String id;
  final String name;
  final String category;
  final double rating;
  final String distance;
  final double deliveryFee;
  final String description;
  final String imageUrl;
  final List<Product> products;

  Store({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.distance,
    required this.deliveryFee,
    required this.description,
    required this.imageUrl,
    required this.products,
  });
}