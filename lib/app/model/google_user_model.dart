class GoogleUserModel {
  final String id;
  final String email;
  final String name;
  final String picture;

  GoogleUserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.picture,
  });

  factory GoogleUserModel.fromJson(Map<String, dynamic> json) {
    return GoogleUserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name, 'picture': picture};
  }
}
