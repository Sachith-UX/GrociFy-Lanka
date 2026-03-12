import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocify/shared/models/address_model.dart';
import 'package:grocify/shared/models/order_model.dart';

class OrdersState {
  final List<Order> orders;
  final bool isLoading;
  final String? error;

  const OrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.error,
  });

  OrdersState copyWith({
    List<Order>? orders,
    bool? isLoading,
    String? error,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class OrdersNotifier extends StateNotifier<OrdersState> {
  OrdersNotifier() : super(const OrdersState()) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock data
      final dummyAddress = Address(
        id: 'addr1',
        userId: 'user1',
        name: 'Home',
        phoneNumber: '+94123456789',
        addressLine1: '123 Main St',
        addressLine2: 'Apt 4B',
        city: 'Colombo',
        postalCode: '00100',
        latitude: 6.9271,
        longitude: 79.8612,
        isDefault: true,
        instructions: 'Leave by the door',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      );

      final mockOrders = [
        Order(
          id: '123456',
          userId: 'user1',
          items: [
            OrderItem(
              productId: 'p1',
              productName: 'Apples',
              productImageUrl: 'assets/images/apple.png',
              price: 250.0,
              quantity: 2,
              total: 500.0,
            ),
          ],
          subtotal: 500.0,
          tax: 25.0,
          deliveryFee: 5.0,
          total: 530.0,
          status: OrderStatus.delivered,
          deliveryAddress: dummyAddress,
          notes: 'Leave by the door',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          updatedAt: DateTime.now().subtract(const Duration(days: 1)),
          deliveredAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Order(
          id: '123457',
          userId: 'user1',
          items: [
            OrderItem(
              productId: 'p2',
              productName: 'Bananas',
              productImageUrl: 'assets/images/banana.png',
              price: 180.0,
              quantity: 3,
              total: 540.0,
            ),
          ],
          subtotal: 540.0,
          tax: 27.0,
          deliveryFee: 5.0,
          total: 572.0,
          status: OrderStatus.outForDelivery,
          deliveryAddress: dummyAddress,
          notes: null,
          createdAt: DateTime.now().subtract(const Duration(hours: 5)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
        ),
        Order(
          id: '123458',
          userId: 'user1',
          items: [
            OrderItem(
              productId: 'p3',
              productName: 'Milk',
              productImageUrl: 'assets/images/milk.png',
              price: 320.0,
              quantity: 1,
              total: 320.0,
            ),
          ],
          subtotal: 320.0,
          tax: 16.0,
          deliveryFee: 5.0,
          total: 341.0,
          status: OrderStatus.preparing,
          deliveryAddress: dummyAddress,
          notes: null,
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
      ];

      state = state.copyWith(orders: mockOrders, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load orders. Please try again.',
      );
    }
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      // TODO: Implement order cancellation
      final updatedOrders = state.orders.map((order) {
        if (order.id == orderId) {
          return order.copyWith(status: OrderStatus.cancelled);
        }
        return order;
      }).toList();

      state = state.copyWith(orders: updatedOrders);
    } catch (e) {
      state = state.copyWith(error: 'Failed to cancel order');
    }
  }

  Future<void> reorder(String orderId) async {
    try {
      // TODO: Implement reorder functionality
      // This would typically add items back to cart
    } catch (e) {
      state = state.copyWith(error: 'Failed to reorder');
    }
  }
}

final ordersProvider = StateNotifierProvider<OrdersNotifier, OrdersState>((ref) {
  return OrdersNotifier();
});