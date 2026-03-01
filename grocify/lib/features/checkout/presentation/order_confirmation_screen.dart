import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/custom_button.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 60,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(height: AppSizes.lg),

              // Title
              Text(
                'Order Confirmed!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSizes.md),

              // Message
              Text(
                'Your order has been placed successfully. You will receive a confirmation email shortly.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSizes.lg),

              // Order details
              Container(
                padding: const EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppSizes.md),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                  ),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(context, 'Order ID', '#123456'),
                    const SizedBox(height: AppSizes.sm),
                    _buildDetailRow(context, 'Estimated Delivery', '30-45 minutes'),
                    const SizedBox(height: AppSizes.sm),
                    _buildDetailRow(context, 'Total Amount', Formatters.formatCurrency(45.99)),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.xl),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Navigate to order tracking
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
                      ),
                      child: const Text('Track Order'),
                    ),
                  ),

                  const SizedBox(width: AppSizes.md),

                  Expanded(
                    child: CustomButton(
                      text: 'Continue Shopping',
                      onPressed: () {
                        // TODO: Navigate to home
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.lg),

              // Additional info
              Text(
                'You can track your order status in the Orders section.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}