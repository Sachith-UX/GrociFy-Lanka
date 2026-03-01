class Category {
  final String id;
  final String name;
  final String iconUrl;
  final String color;
  final int productCount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.color,
    required this.productCount,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      iconUrl: json['iconUrl'] as String,
      color: json['color'] as String,
      productCount: json['productCount'] as int,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconUrl': iconUrl,
      'color': color,
      'productCount': productCount,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Category copyWith({
    String? id,
    String? name,
    String? iconUrl,
    String? color,
    int? productCount,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      iconUrl: iconUrl ?? this.iconUrl,
      color: color ?? this.color,
      productCount: productCount ?? this.productCount,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}