import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/loading_shimmer.dart';
import 'widgets/notification_item.dart';
import 'data/notifications_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsState = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (notificationsState.notifications.isNotEmpty)
            TextButton(
              onPressed: () {
                ref.read(notificationsProvider.notifier).markAllAsRead();
              },
              child: const Text('Mark All Read'),
            ),
        ],
      ),
      body: notificationsState.isLoading
          ? const LoadingShimmer(
              child: Column(
                children: [
                  NotificationItemSkeleton(),
                  NotificationItemSkeleton(),
                  NotificationItemSkeleton(),
                ],
              ),
            )
          : notificationsState.error != null
              ? Center(
                  child: Text(
                    notificationsState.error!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                )
              : notificationsState.notifications.isEmpty
                  ? const EmptyState(
                      title: 'No notifications',
                      message: 'You\'re all caught up!',
                      actionButton: null,
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        await ref.read(notificationsProvider.notifier).loadNotifications();
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(AppSizes.md),
                        itemCount: notificationsState.notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notificationsState.notifications[index];
                          return NotificationItem(
                            notification: notification,
                            onTap: () {
                              ref.read(notificationsProvider.notifier).markAsRead(notification.id);
                              // TODO: Handle notification tap (navigate to relevant screen)
                            },
                          );
                        },
                      ),
                    ),
    );
  }
}