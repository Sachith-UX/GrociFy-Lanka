import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocify/core/constants/app_sizes.dart';
import 'package:grocify/core/utils/formatters.dart';
import 'package:grocify/shared/widgets/empty_state.dart';
import 'package:grocify/shared/widgets/loading_shimmer.dart';
import 'widgets/order_card.dart';
import 'package:grocify/features/orders/data/orders_provider.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersState = ref.watch(ordersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: ordersState.isLoading
          ? ListShimmer(
              itemBuilder: (context, index) => const OrderCardSkeleton(),
            )
          : ordersState.error != null
              ? Center(
                  child: Text(
                    ordersState.error!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                )
              : ordersState.orders.isEmpty
                  ? const EmptyState(
                      title: 'No orders yet',
                      message: 'Your order history will appear here',
                      actionButton: null,
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        await ref.read(ordersProvider.notifier).loadOrders();
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(AppSizes.md),
                        itemCount: ordersState.orders.length,
                        itemBuilder: (context, index) {
                          final order = ordersState.orders[index];
                          return OrderCard(
                            order: order,
                            onTap: () {
                              // TODO: Navigate to order details
                            },
                          );
                        },
                      ),
                    ),
    );
  }
}