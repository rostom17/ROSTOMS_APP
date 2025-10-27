import 'package:rostoms_app/features/products/domain/entities/review_entity.dart';

class ProductEntity {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final List<ReviewEntity> reviews;
  final List<String> images;
  final String thumbnail;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.images,
    required this.thumbnail,
  });
}
