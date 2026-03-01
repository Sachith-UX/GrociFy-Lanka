import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.md),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Row(
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSizes.sm),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(width: AppSizes.md),

              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: AppSizes.xs),

                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow icon
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}