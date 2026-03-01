import 'package:flutter/material.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/utils/formatters.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.sm),

              // Product Name
              Text(
                product.name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: AppSizes.xs),

              // Rating and Reviews
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: AppSizes.iconXS,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    Formatters.formatRating(product.rating),
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${product.reviewCount})',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.sm),

              // Price and Add to Cart
              Row(
                children: [
                  Expanded(
                    child: Text(
                      Formatters.formatCurrency(product.price),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onAddToCart,
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: theme.colorScheme.primary,
                      size: AppSizes.iconMD,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                      padding: const EdgeInsets.all(AppSizes.xs),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}