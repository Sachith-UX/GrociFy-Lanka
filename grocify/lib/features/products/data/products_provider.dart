import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/product_model.dart';

class ProductsState {
  final List<Product> products;
  final bool isLoading;
  final String? error;
  final String? categoryId;
  final String? searchQuery;

  const ProductsState({
    this.products = const [],
    this.isLoading = false,
    this.error,
    this.categoryId,
    this.searchQuery,
  });

  ProductsState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? error,
    String? categoryId,
    String? searchQuery,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      categoryId: categoryId ?? this.categoryId,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ProductsNotifier extends StateNotifier<ProductsState> {
  ProductsNotifier() : super(const ProductsState()) {
    loadProducts();
  }

  Future<void> loadProducts({String? categoryId, String? searchQuery}) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      categoryId: categoryId,
      searchQuery: searchQuery,
    );

    try {
      // TODO: Load products from Firestore
      // For now, using mock data
      await Future.delayed(const Duration(seconds: 1));

      final mockProducts = [
        Product(
          id: '1',
          name: 'Fresh Apples',
          description: 'Red delicious apples',
          price: 250.0,
          imageUrl: 'assets/images/apple.png',
          categoryId: '1',
          stock: 50,
          isAvailable: true,
          rating: 4.5,
          reviewCount: 25,
          tags: ['fresh', 'organic'],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Product(
          id: '2',
          name: 'Organic Bananas',
          description: 'Sweet organic bananas',
          price: 180.0,
          imageUrl: 'assets/images/banana.png',
          categoryId: '1',
          stock: 30,
          isAvailable: true,
          rating: 4.2,
          reviewCount: 18,
          tags: ['organic', 'fresh'],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Product(
          id: '3',
          name: 'Fresh Milk',
          description: '1L fresh cow milk',
          price: 320.0,
          imageUrl: 'assets/images/milk.png',
          categoryId: '3',
          stock: 20,
          isAvailable: true,
          rating: 4.8,
          reviewCount: 42,
          tags: ['dairy', 'fresh'],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      // Filter by category if specified
      List<Product> filteredProducts = mockProducts;
      if (categoryId != null) {
        filteredProducts = mockProducts.where((p) => p.categoryId == categoryId).toList();
      }

      // Filter by search query if specified
      if (searchQuery != null && searchQuery.isNotEmpty) {
        filteredProducts = filteredProducts.where((p) =>
          p.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          p.description.toLowerCase().contains(searchQuery.toLowerCase())
        ).toList();
      }

      state = state.copyWith(products: filteredProducts, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setCategory(String categoryId) {
    loadProducts(categoryId: categoryId);
  }

  void searchProducts(String query) {
    loadProducts(searchQuery: query);
  }
}

final productsProvider = StateNotifierProvider<ProductsNotifier, ProductsState>(
  (ref) => ProductsNotifier(),
);