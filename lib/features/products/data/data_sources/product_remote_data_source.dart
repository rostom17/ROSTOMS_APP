import 'package:dartz/dartz.dart';
import 'package:rostoms_app/features/common/domain/entities/failure.dart';
import 'package:rostoms_app/features/products/data/models/paginated_product_model.dart';

abstract class ProductRemoteDataSource {
  Future<Either<Failure, PaginatedProductModel>> getProducts({
    Map<String, int>? queryParameters,
  });
}
