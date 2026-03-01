import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/notification_model.dart';

class NotificationsState {
  final List<NotificationModel> notifications;
  final bool isLoading;
  final String? error;

  const NotificationsState({
    this.notifications = const [],
    this.isLoading = false,
    this.error,
  });

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  NotificationsState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
    String? error,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class NotificationsNotifier extends StateNotifier<NotificationsState> {
  NotificationsNotifier() : super(const NotificationsState()) {
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock notifications
      final mockNotifications = [
        NotificationModel(
          id: '1',
          title: 'Order Delivered',
          message: 'Your order #123456 has been delivered successfully.',
          type: NotificationType.delivery,
          isRead: false,
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
        NotificationModel(
          id: '2',
          title: 'Special Offer',
          message: 'Get 20% off on fresh vegetables! Limited time offer.',
          type: NotificationType.promotion,
          isRead: false,
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        NotificationModel(
          id: '3',
          title: 'Order Confirmed',
          message: 'Your order #123457 has been confirmed and is being prepared.',
          type: NotificationType.order,
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        ),
        NotificationModel(
          id: '4',
          title: 'App Update Available',
          message: 'A new version of GrociFy Lanka is available. Update now for better experience.',
          type: NotificationType.system,
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        NotificationModel(
          id: '5',
          title: 'Delivery Update',
          message: 'Your order is out for delivery. Expected arrival in 15 minutes.',
          type: NotificationType.delivery,
          isRead: true,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ];

      state = state.copyWith(notifications: mockNotifications, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load notifications. Please try again.',
      );
    }
  }

  void markAsRead(String notificationId) {
    final updatedNotifications = state.notifications.map((notification) {
      if (notification.id == notificationId) {
        return notification.copyWith(isRead: true);
      }
      return notification;
    }).toList();

    state = state.copyWith(notifications: updatedNotifications);
  }

  void markAllAsRead() {
    final updatedNotifications = state.notifications.map((notification) {
      return notification.copyWith(isRead: true);
    }).toList();

    state = state.copyWith(notifications: updatedNotifications);
  }

  void deleteNotification(String notificationId) {
    final updatedNotifications = state.notifications.where(
      (notification) => notification.id != notificationId,
    ).toList();

    state = state.copyWith(notifications: updatedNotifications);
  }

  void clearAllNotifications() {
    state = state.copyWith(notifications: []);
  }
}

final notificationsProvider = StateNotifierProvider<NotificationsNotifier, NotificationsState>((ref) {
  return NotificationsNotifier();
});