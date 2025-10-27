part of 'product_bloc.dart';

sealed class ProductEvent {
  const ProductEvent();
}

class LoadInitialProducts extends ProductEvent {}

class LoadMoreProducts extends ProductEvent {}

class RetryLoadingProducts extends ProductEvent {}
