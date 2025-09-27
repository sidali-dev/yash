class AuthorModel {
  final String id, name;

  AuthorModel({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'\$id': id, 'name': name};
  }

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['\$id'] as String,
      name: json['name'] as String,
    );
  }
}
