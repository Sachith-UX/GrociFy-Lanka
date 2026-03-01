import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/app_sizes.dart';

class LoadingShimmer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const LoadingShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Shimmer.fromColors(
      baseColor: theme.colorScheme.surface,
      highlightColor: theme.colorScheme.surface.withOpacity(0.6),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.borderRadiusMD),
        ),
      ),
    );
  }
}

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            const LoadingShimmer(
              width: double.infinity,
              height: 120,
            ),

            const SizedBox(height: AppSizes.sm),

            // Title placeholder
            LoadingShimmer(
              width: double.infinity,
              height: 16,
            ),

            const SizedBox(height: AppSizes.xs),

            // Subtitle placeholder
            LoadingShimmer(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 14,
            ),

            const SizedBox(height: AppSizes.sm),

            // Price placeholder
            LoadingShimmer(
              width: 80,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class ListShimmer extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const ListShimmer({
    super.key,
    this.itemCount = 5,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}