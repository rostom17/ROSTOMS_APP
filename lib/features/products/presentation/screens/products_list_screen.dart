import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rostoms_app/core/routes/app_routes.dart';
import 'package:rostoms_app/features/products/domain/entities/product_entity.dart';
import 'package:rostoms_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:rostoms_app/features/products/presentation/widgets/custom_appbar.dart';
import 'package:rostoms_app/features/products/presentation/widgets/product_card.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  final _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    context.read<ProductBloc>().add(LoadInitialProducts());
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_isBottom && !_isLoading) {
      _isLoading = true;
      context.read<ProductBloc>().add(LoadMoreProducts());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll * .9;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductLoadFailure) {
              _isLoading = false;
              final errorMessage = state.failureMessage.failureMessage;
              if (errorMessage.contains("401") ||
                  errorMessage.contains("403")) {
                context.pushReplacementNamed(AppRoutes.loginScreen);
                return;
              }
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 3),
                    content: Text(errorMessage),
                    action: SnackBarAction(
                      label: "Retry",
                      onPressed: () {
                        context.read<ProductBloc>().add(RetryLoadingProducts());
                      },
                    ),
                  ),
                );
            }

            if (state is ProductLoadMoreFailure) {
              _isLoading = false;
              if (state.failureMessage.failureMessage.contains("401") ||
                  state.failureMessage.failureMessage.contains("403")) {
                context.pushReplacementNamed(AppRoutes.loginScreen);
                return;
              }
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 3),
                    content: Text(state.failureMessage.failureMessage),
                    action: SnackBarAction(
                      label: "Retry",
                      onPressed: () {
                        context.read<ProductBloc>().add(RetryLoadingProducts());
                      },
                    ),
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state is ProductInitial || state is ProductLoading) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is ProductLoadFailure) {
              _isLoading = false;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.failureMessage.failureMessage,
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        context.read<ProductBloc>().add(LoadInitialProducts());
                      },
                      child: Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            if (state is ProductLoadSuccess ||
                state is ProductLoadMoreFailure) {
              _isLoading = false;
              final products = state is ProductLoadSuccess
                  ? state.products
                  : (state as ProductLoadMoreFailure).products;
              final isLoadingMore =
                  state is ProductLoadSuccess && state.isLoadingMore;
              if (products.isEmpty) {
                return const Center(child: Text("No Products"));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProductBloc>().add(LoadInitialProducts());
                },
                child: _buildCustomScrollView(products, isLoadingMore),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildCustomScrollView(
    List<ProductEntity> products,
    bool isLoadingMore,
  ) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ProductCard(product: products[index]);
          }, childCount: products.length),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
        if (isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator.adaptive()),
            ),
          ),
      ],
    );
  }
}
