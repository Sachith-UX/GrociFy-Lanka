import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../shared/models/product_model.dart';
import '../../../shared/widgets/loading_shimmer.dart';
import '../../../shared/widgets/product_card.dart';
import '../data/products_provider.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Show filter options
            },
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // TODO: Show sort options
            },
          ),
        ],
      ),
      body: productsState.isLoading
          ? const _LoadingGrid()
          : productsState.error != null
              ? _ErrorView(error: productsState.error!)
              : _ProductsGrid(products: productsState.products),
    );
  }
}

class _LoadingGrid extends StatelessWidget {
  const _LoadingGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppSizes.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSizes.md,
        mainAxisSpacing: AppSizes.md,
        childAspectRatio: 0.75,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => const ProductCardShimmer(),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;

  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            'Failed to load products',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSizes.sm),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.lg),
          ElevatedButton(
            onPressed: () {
              // TODO: Retry loading
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _ProductsGrid extends StatelessWidget {
  final List<Product> products;

  const _ProductsGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Text('No products found'),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppSizes.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSizes.md,
        mainAxisSpacing: AppSizes.md,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onTap: () {
            // TODO: Navigate to product detail
          },
          onAddToCart: () {
            // TODO: Add to cart
          },
        );
      },
    );
  }
}