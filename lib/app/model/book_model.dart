import 'package:yash/app/model/author_model.dart';
import 'package:yash/app/model/category_model.dart';

class BookModel {
  final String id;
  final String title;
  final String description;
  final String cover;
  final String file;
  final String isbn;
  final int price;
  final int pageCount;
  final AuthorModel authorModel;
  final CategoryModel categoryModel;
  final DateTime createdAt;

  BookModel({
    required this.id,
    required this.title,
    required this.description,
    required this.cover,
    required this.file,
    required this.isbn,
    required this.price,
    required this.pageCount,
    required this.authorModel,
    required this.categoryModel,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '\$id': id,
      'title': title,
      'description': description,
      'cover': cover,
      'file': file,
      'isbn_number': isbn,
      'price': price,
      'page_count': pageCount,
      'author': authorModel.toJson(),
      'category': categoryModel.toJson(),
      '\$createdAt': createdAt.toIso8601String(),
    };
  }

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['\$id'],
      title: json['title'],
      description: json['description'],
      cover: json['cover'],
      file: json['file'],
      isbn: json['isbn_number'],
      price: json['price'],
      pageCount: json['page_count'],
      authorModel: AuthorModel.fromJson(json['author']),
      categoryModel: CategoryModel.fromJson(json['category']),
      createdAt: DateTime.parse(json['\$createdAt']),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
