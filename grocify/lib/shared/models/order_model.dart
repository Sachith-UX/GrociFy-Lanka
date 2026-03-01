enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  pickedUp,
  delivered,
  cancelled,
}

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.ready:
        return 'Ready for Pickup';
      case OrderStatus.pickedUp:
        return 'Picked Up';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isActive => this != OrderStatus.delivered && this != OrderStatus.cancelled;
}

class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double total;
  final OrderStatus status;
  final Address deliveryAddress;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deliveredAt;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.total,
    required this.status,
    required this.deliveryAddress,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.deliveredAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      subtotal: (json['subtotal'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      status: OrderStatus.values[json['status'] as int],
      deliveryAddress: Address.fromJson(json['deliveryAddress'] as Map<String, dynamic>),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deliveredAt: json['deliveredAt'] != null
          ? DateTime.parse(json['deliveredAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'subtotal': subtotal,
      'tax': tax,
      'deliveryFee': deliveryFee,
      'total': total,
      'status': status.index,
      'deliveryAddress': deliveryAddress.toJson(),
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deliveredAt': deliveredAt?.toIso8601String(),
    };
  }

  Order copyWith({
    String? id,
    String? userId,
    List<OrderItem>? items,
    double? subtotal,
    double? tax,
    double? deliveryFee,
    double? total,
    OrderStatus? status,
    Address? deliveryAddress,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deliveredAt,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
      status: status ?? this.status,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
    );
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final String productImageUrl;
  final double price;
  final int quantity;
  final double total;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.productImageUrl,
    required this.price,
    required this.quantity,
    required this.total,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productImageUrl: json['productImageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      total: (json['total'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productImageUrl': productImageUrl,
      'price': price,
      'quantity': quantity,
      'total': total,
    };
  }
}