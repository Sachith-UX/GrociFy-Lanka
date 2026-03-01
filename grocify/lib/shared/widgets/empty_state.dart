import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_images.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final String? animationPath;
  final Widget? actionButton;
  final double? height;

  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.animationPath,
    this.actionButton,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (animationPath != null) ...[
                Lottie.asset(
                  animationPath!,
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: AppSizes.lg),
              ] else ...[
                Icon(
                  Icons.inbox,
                  size: 80,
                  color: theme.colorScheme.onSurface.withOpacity(0.3),
                ),
                const SizedBox(height: AppSizes.lg),
              ],

              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSizes.md),

              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),

              if (actionButton != null) ...[
                const SizedBox(height: AppSizes.lg),
                actionButton!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}