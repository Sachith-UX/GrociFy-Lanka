import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/order_model.dart';

class OrdersState {
  final List<OrderModel> orders;
  final bool isLoading;
  final String? error;

  const OrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.error,
  });

  OrdersState copyWith({
    List<OrderModel>? orders,
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
      final mockOrders = [
        OrderModel(
          id: '123456',
          userId: 'user1',
          items: const [], // TODO: Add order items
          totalAmount: 45.99,
          status: OrderStatus.delivered,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          deliveredAt: DateTime.now().subtract(const Duration(days: 1)),
          deliveryAddress: '123 Main St, Colombo',
          paymentMethod: 'Cash on Delivery',
        ),
        OrderModel(
          id: '123457',
          userId: 'user1',
          items: const [], // TODO: Add order items
          totalAmount: 32.50,
          status: OrderStatus.outForDelivery,
          createdAt: DateTime.now().subtract(const Duration(hours: 5)),
          deliveryAddress: '456 Oak Ave, Colombo',
          paymentMethod: 'Credit Card',
        ),
        OrderModel(
          id: '123458',
          userId: 'user1',
          items: const [], // TODO: Add order items
          totalAmount: 28.75,
          status: OrderStatus.preparing,
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          deliveryAddress: '789 Pine St, Colombo',
          paymentMethod: 'UPI',
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