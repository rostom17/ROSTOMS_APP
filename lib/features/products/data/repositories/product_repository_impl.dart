import 'package:dartz/dartz.dart';
import 'package:rostoms_app/features/common/domain/entities/failure.dart';
import 'package:rostoms_app/features/products/data/data_sources/product_remote_data_source.dart';
import 'package:rostoms_app/features/products/domain/entities/product_api_response_entity.dart';
import 'package:rostoms_app/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  ProductRepositoryImpl({required this.productRemoteDataSource});

  @override
  Future<Either<Failure, ProductApiResponseEntity>> getProducts({
    Map<String, int>? queryParameters,
  }) async {
    try {
      final response = await productRemoteDataSource.getProducts(queryParameters: queryParameters);
      return response.fold((error) => Left(error), (paginatedProductModel) {
        return Right(paginatedProductModel.toEntity());
      });
    } catch (e) {
      return Left(Failure(failureMessage: "$e: An Unknown error occured"));
    }
  }
}
