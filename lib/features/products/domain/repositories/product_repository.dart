import 'package:dartz/dartz.dart';
import 'package:rostoms_app/features/common/domain/entities/failure.dart';
import 'package:rostoms_app/features/products/domain/entities/product_api_response_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductApiResponseEntity>> getProducts({
    Map<String, int> queryParameters,
  });
}
