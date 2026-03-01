import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/models/cart_item_model.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Row(
          children: [
            // Product image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.sm),
                image: DecorationImage(
                  image: NetworkImage(item.productImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: AppSizes.md),

            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: AppSizes.xs),

                  Text(
                    Formatters.formatCurrency(item.price),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: AppSizes.md),

            // Quantity controls
            Column(
              children: [
                // Remove button
                IconButton(
                  onPressed: onRemove,
                  icon: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  iconSize: 20,
                ),

                // Quantity controls
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.sm),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: onDecrement,
                        icon: const Icon(Icons.remove),
                        iconSize: 16,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        padding: EdgeInsets.zero,
                      ),

                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(
                          item.quantity.toString(),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: onIncrement,
                        icon: const Icon(Icons.add),
                        iconSize: 16,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSizes.sm),

                // Item total
                Text(
                  Formatters.formatCurrency(item.total),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}