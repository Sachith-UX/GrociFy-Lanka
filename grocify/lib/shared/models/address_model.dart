class Address {
  final String id;
  final String userId;
  final String name;
  final String phoneNumber;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String postalCode;
  final double latitude;
  final double longitude;
  final bool isDefault;
  final String? instructions;
  final DateTime createdAt;
  final DateTime updatedAt;

  Address({
    required this.id,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
    this.instructions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String?,
      city: json['city'] as String,
      postalCode: json['postalCode'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      isDefault: json['isDefault'] as bool,
      instructions: json['instructions'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'phoneNumber': phoneNumber,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'postalCode': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'isDefault': isDefault,
      'instructions': instructions,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Address copyWith({
    String? id,
    String? userId,
    String? name,
    String? phoneNumber,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? postalCode,
    double? latitude,
    double? longitude,
    bool? isDefault,
    String? instructions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Address(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isDefault: isDefault ?? this.isDefault,
      instructions: instructions ?? this.instructions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get fullAddress {
    final parts = [addressLine1];
    if (addressLine2 != null && addressLine2!.isNotEmpty) {
      parts.add(addressLine2!);
    }
    parts.add('$city $postalCode');
    return parts.join(', ');
  }

  String get displayName {
    return '$name - $fullAddress';
  }
}