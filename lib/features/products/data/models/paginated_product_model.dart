import 'package:rostoms_app/features/common/data/models/base_model.dart';
import 'package:rostoms_app/features/products/data/models/product_model.dart';
import 'package:rostoms_app/features/products/domain/entities/product_api_response_entity.dart';

class PaginatedProductModel implements BaseModel<ProductApiResponseEntity> {
  final List<ProductModel> products;
  final int total;
  final int skip;
  final int limit;

  PaginatedProductModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory PaginatedProductModel.fromJson(Map<String, dynamic> json) {
    return PaginatedProductModel(
      products: (json['products'] as List<dynamic>)
          .map((productJson) => ProductModel.formJson(productJson))
          .toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }

  @override
  ProductApiResponseEntity toEntity() {
    return ProductApiResponseEntity(
      products: products
          .map((productModel) => productModel.toEntity())
          .toList(),
      total: total,
      skip: skip,
      limit: limit,
    );
  }
}
