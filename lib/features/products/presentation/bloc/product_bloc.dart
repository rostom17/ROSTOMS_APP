import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rostoms_app/features/common/domain/entities/failure.dart';
import 'package:rostoms_app/features/products/domain/entities/product_entity.dart';
import 'package:rostoms_app/features/products/domain/usecases/fetch_products_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final FetchProductsUsecase _fetchProductsUsecase;
  int _currentSkipProduct = 0;
  List<ProductEntity> _allProducts = [];

  ProductBloc({required FetchProductsUsecase getLimitedProductsUsecase})
    : _fetchProductsUsecase = getLimitedProductsUsecase,
      super(ProductInitial()) {
    on<LoadInitialProducts>(_onFetchInitialProducts);
    on<LoadMoreProducts>(_onLoadMoreProducts);
    on<RetryLoadingProducts>(_onRetryLoadingProducts);
  }

  Future<void> _onFetchInitialProducts(
    LoadInitialProducts event,
    Emitter<ProductState> emit,
  ) async {
    _currentSkipProduct = 0;
    _allProducts.clear();
    emit(const ProductLoading());

    final result = await _fetchProductsUsecase.call(_currentSkipProduct);
    result.fold(
      (error) {
        emit(ProductLoadFailure(failureMessage: error));
      },
      (response) {
        _allProducts = response.products;
        _currentSkipProduct =
            response.limit + response.skip;
        emit(
          ProductLoadSuccess(
            products: _allProducts,
            hasMoreProducts: response.hasMoreProduct,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProducts event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    bool hasMoreProducts;
    bool isCurrentlyLoadingMore;

    if (currentState is ProductLoadSuccess) {
      hasMoreProducts = currentState.hasMoreProducts;
      isCurrentlyLoadingMore = currentState.isLoadingMore;
    } else if (currentState is ProductLoadMoreFailure) {
      hasMoreProducts = currentState.hasMoreProducts;
      isCurrentlyLoadingMore = false;
    } else {
      return;
    }

    if (!hasMoreProducts || isCurrentlyLoadingMore) return;

    if (currentState is ProductLoadSuccess) {
      emit(currentState.copyWith(isLoadingMore: true));
    } else if (currentState is ProductLoadMoreFailure) {
      emit(
        ProductLoadSuccess(
          products: List.from(currentState.products),
          hasMoreProducts: currentState.hasMoreProducts,
          isLoadingMore: true,
        ),
      );
    }
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); //i added this for clear visibility of loading bar
    final result = await _fetchProductsUsecase.call(_currentSkipProduct);
    result.fold(
      (error) {
        emit(
          ProductLoadMoreFailure(
            products: List.from(_allProducts),
            hasMoreProducts: hasMoreProducts,
            failureMessage: error,
          ),
        );
      },
      (response) {
        _allProducts.addAll(response.products);
        _currentSkipProduct =
            response.limit + response.skip;
        emit(
          ProductLoadSuccess(
            products: List.from(_allProducts),
            hasMoreProducts: response.hasMoreProduct,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  Future<void> _onRetryLoadingProducts(
    RetryLoadingProducts event,
    Emitter<ProductState> emit,
  ) async {
    if (_allProducts.isEmpty) {
      add(LoadInitialProducts());
      return;
    }
    final currentState = state;
    if (currentState is ProductLoadSuccess &&
        !currentState.isLoadingMore &&
        currentState.hasMoreProducts) {
      add(LoadMoreProducts());
    } else if (currentState is ProductLoadMoreFailure &&
        currentState.hasMoreProducts) {
      add(LoadMoreProducts());
    }
  }
}
