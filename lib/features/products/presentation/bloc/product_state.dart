part of 'product_bloc.dart';

sealed class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoadFailure extends ProductState {
  final Failure failureMessage;
  ProductLoadFailure({required this.failureMessage});
}

class ProductLoadMoreFailure extends ProductState {
  final List<ProductEntity> products;
  final bool hasMoreProducts;
  final Failure failureMessage;

  ProductLoadMoreFailure({
    required this.products,
    required this.hasMoreProducts,
    required this.failureMessage,
  });
}

class ProductLoadSuccess extends ProductState {
  final List<ProductEntity> products;
  final bool isLoadingMore;
  final bool hasMoreProducts;

  ProductLoadSuccess({
    required this.products,
    required this.hasMoreProducts,
    this.isLoadingMore = false,
  });

  ProductLoadSuccess copyWith({
    List<ProductEntity>? products,
    bool? hasMoreProducts,
    bool? isLoadingMore,
  }) {
    return ProductLoadSuccess(
      products: products ?? this.products,
      hasMoreProducts: hasMoreProducts ?? this.hasMoreProducts,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
