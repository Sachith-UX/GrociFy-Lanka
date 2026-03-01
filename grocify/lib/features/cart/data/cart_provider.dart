import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/cart_item_model.dart';
import '../../../shared/models/product_model.dart';

class CartState {
  final List<CartItem> items;
  final bool isLoading;
  final String? error;

  const CartState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);
  double get deliveryFee => subtotal > 50 ? 0 : 5.99; // Free delivery over $50
  double get total => subtotal + deliveryFee;

  CartState copyWith({
    List<CartItem>? items,
    bool? isLoading,
    String? error,
  }) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState());

  void addItem(Product product, {int quantity = 1}) {
    final existingIndex = state.items.indexWhere(
      (item) => item.productId == product.id,
    );

    if (existingIndex != -1) {
      // Update existing item quantity
      final existingItem = state.items[existingIndex];
      final updatedItem = existingItem.copyWith(quantity: existingItem.quantity + quantity);

      final updatedItems = List<CartItem>.from(state.items);
      updatedItems[existingIndex] = updatedItem;

      state = state.copyWith(items: updatedItems);
    } else {
      // Add new item
      final newItem = CartItem(
        productId: product.id,
        productName: product.name,
        productImageUrl: product.imageUrl,
        price: product.price,
        quantity: quantity,
      );

      state = state.copyWith(items: [...state.items, newItem]);
    }
  }

  void removeItem(String productId) {
    final updatedItems = state.items.where(
      (item) => item.productId != productId,
    ).toList();

    state = state.copyWith(items: updatedItems);
  }

  void incrementQuantity(String productId) {
    final updatedItems = state.items.map((item) {
      if (item.productId == productId) {
        return item.increaseQuantity();
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }

  void decrementQuantity(String productId) {
    final updatedItems = state.items.map((item) {
      if (item.productId == productId) {
        return item.decreaseQuantity();
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }

  void clearCart() {
    state = state.copyWith(items: []);
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
      return;
    }

    final updatedItems = state.items.map((item) {
      if (item.productId == productId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }

  int getItemCount() {
    return state.items.fold(0, (sum, item) => sum + item.quantity);
  }

  bool isInCart(String productId) {
    return state.items.any((item) => item.productId == productId);
  }

  CartItem? getItem(String productId) {
    return state.items.cast<CartItem?>().firstWhere(
      (item) => item?.productId == productId,
      orElse: () => null,
    );
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});