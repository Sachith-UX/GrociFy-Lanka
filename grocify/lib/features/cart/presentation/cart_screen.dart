import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/empty_state.dart';
import 'widgets/cart_item_tile.dart';
import 'data/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          if (cartState.items.isNotEmpty)
            TextButton(
              onPressed: () {
                // TODO: Clear cart
              },
              child: const Text('Clear All'),
            ),
        ],
      ),
      body: cartState.items.isEmpty
          ? const EmptyState(
              title: 'Your cart is empty',
              message: 'Add some delicious items to your cart',
              actionButton: CustomButton(
                text: 'Start Shopping',
                onPressed: null, // TODO: Navigate to home
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(AppSizes.md),
                    itemCount: cartState.items.length,
                    itemBuilder: (context, index) {
                      final item = cartState.items[index];
                      return CartItemTile(
                        item: item,
                        onIncrement: () {
                          ref.read(cartProvider.notifier).incrementQuantity(item.productId);
                        },
                        onDecrement: () {
                          ref.read(cartProvider.notifier).decrementQuantity(item.productId);
                        },
                        onRemove: () {
                          ref.read(cartProvider.notifier).removeItem(item.productId);
                        },
                      );
                    },
                  ),
                ),

                // Cart summary
                Container(
                  padding: const EdgeInsets.all(AppSizes.md),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Subtotal
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            Formatters.formatCurrency(cartState.subtotal),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSizes.sm),

                      // Delivery fee
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Fee',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            Formatters.formatCurrency(cartState.deliveryFee),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSizes.sm),

                      // Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            Formatters.formatCurrency(cartState.total),
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSizes.lg),

                      // Checkout button
                      CustomButton(
                        text: 'Proceed to Checkout',
                        onPressed: () {
                          // TODO: Navigate to checkout
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}