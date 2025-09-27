class CategoryModel {
  final String id, category;

  CategoryModel({required this.id, required this.category});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'\$id': id, 'name': category};
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json["\$id"], category: json["name"]);
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id;
}
