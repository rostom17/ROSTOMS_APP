import 'package:rostoms_app/features/common/data/models/base_model.dart';
import 'package:rostoms_app/features/products/data/models/review_model.dart';
import 'package:rostoms_app/features/products/domain/entities/product_entity.dart';

class ProductModel implements BaseModel<ProductEntity> {
  final int? id;
  final String? title;
  final String? description;
  final double? price;
  final double? rating;
  final List<ReviewModel>? reviews;
  final List<String>? images;
  final String? thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.images,
    required this.thumbnail,
  });

  factory ProductModel.formJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      rating: json['rating'],
      reviews: (json['reviews'] as List<dynamic>)
          .map((reviewJson) => ReviewModel.fromJson(reviewJson))
          .toList(),
      images: (json['images'] as List<dynamic>)
          .map((image) => image.toString())
          .toList(),
      thumbnail: json['thumbnail'],
    );
  }

  @override
  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? -1,
      title: title ?? "Unknown",
      description: description ?? "No Description",
      price: price ?? 0.00,
      rating: rating ?? 0,
      reviews: reviews?.map((r) => r.toEntity()).toList() ?? [],
      images: images ?? [],
      thumbnail: thumbnail ?? "",
    );
  }
}
