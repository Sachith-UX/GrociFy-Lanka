import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/models/order_model.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  final OrderModel order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.md),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #${order.id}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  _buildStatusChip(context, order.status),
                ],
              ),

              const SizedBox(height: AppSizes.sm),

              // Order date
              Text(
                Formatters.formatDateTime(order.createdAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: AppSizes.md),

              // Order items preview
              Text(
                '${order.items.length} item${order.items.length == 1 ? '' : 's'}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: AppSizes.sm),

              // Order total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    Formatters.formatCurrency(order.totalAmount),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),

              if (order.status == OrderStatus.delivered) ...[
                const SizedBox(height: AppSizes.sm),
                Text(
                  'Delivered on ${Formatters.formatDateTime(order.deliveredAt!)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, OrderStatus status) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case OrderStatus.pending:
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        break;
      case OrderStatus.confirmed:
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
        break;
      case OrderStatus.preparing:
        backgroundColor = Colors.purple.withOpacity(0.1);
        textColor = Colors.purple;
        break;
      case OrderStatus.outForDelivery:
        backgroundColor = Colors.indigo.withOpacity(0.1);
        textColor = Colors.indigo;
        break;
      case OrderStatus.delivered:
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        break;
      case OrderStatus.cancelled:
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.sm,
        vertical: AppSizes.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.sm),
      ),
      child: Text(
        status.displayName,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class OrderCardSkeleton extends StatelessWidget {
  const OrderCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 20,
                  color: Colors.grey.shade300,
                ),
                Container(
                  width: 80,
                  height: 24,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
            const SizedBox(height: AppSizes.sm),
            Container(
              width: 120,
              height: 16,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: AppSizes.md),
            Container(
              width: 80,
              height: 16,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: AppSizes.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 18,
                  color: Colors.grey.shade300,
                ),
                Container(
                  width: 60,
                  height: 18,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}