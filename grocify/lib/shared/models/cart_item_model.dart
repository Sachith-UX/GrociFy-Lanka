class CartItem {
  final String productId;
  final String productName;
  final String productImageUrl;
  final double price;
  final int quantity;
  final double total;

  CartItem({
    required this.productId,
    required this.productName,
    required this.productImageUrl,
    required this.price,
    required this.quantity,
  }) : total = price * quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productImageUrl: json['productImageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productImageUrl': productImageUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  CartItem copyWith({
    String? productId,
    String? productName,
    String? productImageUrl,
    double? price,
    int? quantity,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  CartItem increaseQuantity() {
    return copyWith(quantity: quantity + 1);
  }

  CartItem decreaseQuantity() {
    if (quantity > 1) {
      return copyWith(quantity: quantity - 1);
    }
    return this;
  }
}