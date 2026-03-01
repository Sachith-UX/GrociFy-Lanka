import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/models/notification_model.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final NotificationModel notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.sm),
      color: notification.isRead
          ? Theme.of(context).colorScheme.surface
          : Theme.of(context).colorScheme.primary.withOpacity(0.05),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.md),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notification icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getIconColor(context).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSizes.sm),
                ),
                child: Icon(
                  _getIcon(),
                  color: _getIconColor(context),
                  size: 20,
                ),
              ),

              const SizedBox(width: AppSizes.md),

              // Notification content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      notification.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: AppSizes.xs),

                    // Message
                    Text(
                      notification.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: AppSizes.sm),

                    // Timestamp
                    Text(
                      Formatters.formatTimeAgo(notification.createdAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // Unread indicator
              if (!notification.isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon() {
    switch (notification.type) {
      case NotificationType.order:
        return Icons.shopping_bag;
      case NotificationType.delivery:
        return Icons.delivery_dining;
      case NotificationType.promotion:
        return Icons.local_offer;
      case NotificationType.system:
        return Icons.info;
    }
  }

  Color _getIconColor(BuildContext context) {
    switch (notification.type) {
      case NotificationType.order:
        return Colors.blue;
      case NotificationType.delivery:
        return Colors.green;
      case NotificationType.promotion:
        return Colors.orange;
      case NotificationType.system:
        return Colors.purple;
    }
  }
}

class NotificationItemSkeleton extends StatelessWidget {
  const NotificationItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.sm),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              color: Colors.grey.shade300,
            ),

            const SizedBox(width: AppSizes.md),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 20,
                    color: Colors.grey.shade300,
                  ),

                  const SizedBox(height: AppSizes.xs),

                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.grey.shade300,
                  ),

                  const SizedBox(height: AppSizes.xs),

                  Container(
                    width: 100,
                    height: 16,
                    color: Colors.grey.shade300,
                  ),

                  const SizedBox(height: AppSizes.sm),

                  Container(
                    width: 80,
                    height: 14,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}