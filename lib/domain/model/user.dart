class User {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final DateTime? email_verified_at;
  final String password;
  final String? avatar;
  final String status;
  final String? noti_token;
  final String? provider;
  final String? providerId;
  final int roleId;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.email_verified_at,
    required this.password,
    this.avatar,
    required this.status,
    this.noti_token,
    this.provider,
    this.providerId,
    required this.roleId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] ?? '', // Use default empty string if null
      email: json['email'] ?? '', // Use default empty string if null
      phone: json['phone'],
      email_verified_at: json['email_verified_at'] != null ? DateTime.parse(json['email_verified_at']) : null,
      password: json['password'] ?? '', // Use default empty string if null
      avatar: json['avatar'],
      status: json['status'] ?? '', // Use default empty string if null
      noti_token: json['noti_token'],
      provider: json['provider'],
      providerId: json['provider_id'],
      roleId: json['role_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'email_verified_at': email_verified_at?.toIso8601String(),
      'password': password,
      'avatar': avatar,
      'status': status,
      'noti_token': noti_token,
      'provider': provider,
      'provider_id': providerId,
      'role_id': roleId,
    };
  }
}
