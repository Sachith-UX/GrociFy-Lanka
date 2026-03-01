import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../shared/models/product_model.dart';
import '../../../shared/widgets/loading_shimmer.dart';
import '../../../shared/widgets/product_card.dart';
import 'data/products_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      ref.read(productsProvider.notifier).searchProducts(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          decoration: const InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          onSubmitted: _performSearch,
          onChanged: (value) {
            if (value.isEmpty) {
              // Clear search results
              ref.read(productsProvider.notifier).loadProducts();
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              ref.read(productsProvider.notifier).loadProducts();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search suggestions or recent searches could go here

          Expanded(
            child: productsState.isLoading
                ? const _LoadingGrid()
                : productsState.error != null
                    ? _ErrorView(error: productsState.error!)
                    : _SearchResults(products: productsState.products),
          ),
        ],
      ),
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
            'Search failed',
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
        ],
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  final List<Product> products;

  const _SearchResults({required this.products});

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