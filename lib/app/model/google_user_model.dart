class UserModel {
  final String id;
  final String email;
  final String name;
  final String? picture;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.picture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      picture: json['picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name, 'picture': picture};
  }
}
