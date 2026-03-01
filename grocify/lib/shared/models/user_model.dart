class User {
  final String id;
  final String phoneNumber;
  final String? name;
  final String? email;
  final String? profilePhotoUrl;
  final List<Address> addresses;
  final bool isPhoneVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.phoneNumber,
    this.name,
    this.email,
    this.profilePhotoUrl,
    required this.addresses,
    required this.isPhoneVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((address) => Address.fromJson(address as Map<String, dynamic>))
          .toList() ?? [],
      isPhoneVerified: json['isPhoneVerified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'profilePhotoUrl': profilePhotoUrl,
      'addresses': addresses.map((address) => address.toJson()).toList(),
      'isPhoneVerified': isPhoneVerified,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? phoneNumber,
    String? name,
    String? email,
    String? profilePhotoUrl,
    List<Address>? addresses,
    bool? isPhoneVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      addresses: addresses ?? this.addresses,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isProfileComplete => name != null && name!.isNotEmpty;
}