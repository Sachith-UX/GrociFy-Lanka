import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/category_model.dart';

class HomeState {
  final List<Category> categories;
  final bool isLoading;
  final String? error;

  const HomeState({
    this.categories = const [],
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    List<Category>? categories,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(const HomeState()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // TODO: Load categories from Firestore
      // For now, using mock data
      await Future.delayed(const Duration(seconds: 1));

      final mockCategories = [
        Category(
          id: '1',
          name: 'Fruits',
          iconUrl: 'assets/icons/fruits.png',
          color: '#4CAF50',
          productCount: 25,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Category(
          id: '2',
          name: 'Vegetables',
          iconUrl: 'assets/icons/vegetables.png',
          color: '#8BC34A',
          productCount: 40,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Category(
          id: '3',
          name: 'Dairy',
          iconUrl: 'assets/icons/dairy.png',
          color: '#FFC107',
          productCount: 15,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Category(
          id: '4',
          name: 'Beverages',
          iconUrl: 'assets/icons/beverages.png',
          color: '#2196F3',
          productCount: 20,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      state = state.copyWith(categories: mockCategories, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) => HomeNotifier(),
);