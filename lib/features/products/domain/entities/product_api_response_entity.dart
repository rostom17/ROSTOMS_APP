import 'package:rostoms_app/features/products/domain/entities/product_entity.dart';

class ProductApiResponseEntity {
  final List<ProductEntity> products;
  final int total;
  final int skip;
  final int limit;

  ProductApiResponseEntity({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  bool get hasMoreProduct => skip + limit < total;
}
