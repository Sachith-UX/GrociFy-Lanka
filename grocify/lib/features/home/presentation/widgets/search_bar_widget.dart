import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_sizes.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => context.go('/search'),
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.sm,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMD),
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              size: AppSizes.iconMD,
            ),

            const SizedBox(width: AppSizes.sm),

            Expanded(
              child: Text(
                'Search for groceries...',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),

            Icon(
              Icons.mic,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              size: AppSizes.iconMD,
            ),
          ],
        ),
      ),
    );
  }
}