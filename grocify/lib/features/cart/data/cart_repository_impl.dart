import 'package:hive/hive.dart';
import '../../../shared/models/cart_item_model.dart';
import 'cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  static const String _cartBoxName = 'cart_box';

  Future<Box<CartItem>> _getCartBox() async {
    return await Hive.openBox<CartItem>(_cartBoxName);
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    final box = await _getCartBox();
    return box.values.toList();
  }

  @override
  Future<void> addItem(CartItem item) async {
    final box = await _getCartBox();
    await box.put(item.productId, item);
  }

  @override
  Future<void> removeItem(String productId) async {
    final box = await _getCartBox();
    await box.delete(productId);
  }

  @override
  Future<void> updateQuantity(String productId, int quantity) async {
    final box = await _getCartBox();
    final item = box.get(productId);

    if (item != null) {
      final updatedItem = item.copyWith(quantity: quantity);
      await box.put(productId, updatedItem);
    }
  }

  @override
  Future<void> clearCart() async {
    final box = await _getCartBox();
    await box.clear();
  }
}