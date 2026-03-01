import '../../../shared/models/cart_item_model.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCartItems();
  Future<void> addItem(CartItem item);
  Future<void> removeItem(String productId);
  Future<void> updateQuantity(String productId, int quantity);
  Future<void> clearCart();
}