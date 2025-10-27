import 'package:dartz/dartz.dart';
import 'package:rostoms_app/core/constants/api_constants.dart';
import 'package:rostoms_app/core/network/models/network_request_model.dart';
import 'package:rostoms_app/core/network/models/network_response_model.dart';
import 'package:rostoms_app/core/network/network_executor.dart';
import 'package:rostoms_app/features/common/domain/entities/failure.dart';
import 'package:rostoms_app/features/products/data/data_sources/product_remote_data_source.dart';
import 'package:rostoms_app/features/products/data/models/paginated_product_model.dart';

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final NetworkExecutor networkExecutor;

  ProductRemoteDataSourceImpl({required this.networkExecutor});

  @override
  Future<Either<Failure, PaginatedProductModel>> getProducts({
    Map<String, int>? queryParameters,
  }) async {
    final NetworkResponseModel networkResponseModel = await networkExecutor
        .getRequest(
          NetworkRequestModel(
            path: ApiConstants.productEndPoint,
            queryParams: queryParameters,
          ),
        );

    if (networkResponseModel.statusCode == 200) {
      final jsonMap = networkResponseModel.body as Map<String, dynamic>;
      return Right(PaginatedProductModel.fromJson(jsonMap));
    } else {
      return Left(Failure(failureMessage: networkResponseModel.message));
    }
  }
}
