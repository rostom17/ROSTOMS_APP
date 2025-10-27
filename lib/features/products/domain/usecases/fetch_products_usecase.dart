import 'package:dartz/dartz.dart';
import 'package:rostoms_app/core/constants/api_constants.dart';
import 'package:rostoms_app/features/common/domain/entities/failure.dart';
import 'package:rostoms_app/features/common/domain/usecases/base_usecase.dart';
import 'package:rostoms_app/features/products/domain/entities/product_api_response_entity.dart';
import 'package:rostoms_app/features/products/domain/repositories/product_repository.dart';

class FetchProductsUsecase
    implements BaseUsecase<Either<Failure, ProductApiResponseEntity>, int> {
  final ProductRepository productRepository;

  FetchProductsUsecase({required this.productRepository});

  @override
  Future<Either<Failure, ProductApiResponseEntity>> call(
    int skipProducts,
  ) async {
    return await productRepository.getProducts(
      queryParameters: {
        "limit": ApiConstants.paginationLimit,
        "skip": skipProducts,
      },
    );
  }
}
