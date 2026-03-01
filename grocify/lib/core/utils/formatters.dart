import 'package:intl/intl.dart';

class Formatters {
  static final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'en_LK',
    symbol: 'Rs. ',
    decimalDigits: 2,
  );

  static final DateFormat dateFormatter = DateFormat('MMM dd, yyyy');
  static final DateFormat timeFormatter = DateFormat('hh:mm a');
  static final DateFormat dateTimeFormatter = DateFormat('MMM dd, yyyy hh:mm a');

  static String formatCurrency(double amount) {
    return currencyFormatter.format(amount);
  }

  static String formatDate(DateTime date) {
    return dateFormatter.format(date);
  }

  static String formatTime(DateTime time) {
    return timeFormatter.format(time);
  }

  static String formatDateTime(DateTime dateTime) {
    return dateTimeFormatter.format(dateTime);
  }

  static String formatDistance(double distanceInKm) {
    if (distanceInKm < 1) {
      return '${(distanceInKm * 1000).round()}m';
    } else {
      return '${distanceInKm.toStringAsFixed(1)}km';
    }
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Format Sri Lankan phone numbers
    if (phoneNumber.startsWith('+94')) {
      return phoneNumber;
    } else if (phoneNumber.startsWith('0')) {
      return '+94${phoneNumber.substring(1)}';
    } else {
      return '+94$phoneNumber';
    }
  }

  static String formatOrderId(String orderId) {
    return '#${orderId.toUpperCase()}';
  }

  static String formatRating(double rating) {
    return rating.toStringAsFixed(1);
  }

  static String formatPercentage(double value) {
    return '${value.toStringAsFixed(0)}%';
  }
}