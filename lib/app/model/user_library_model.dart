import 'package:yash/app/model/book_model.dart';

class UserLibraryModel {
  final String id, userId;
  final List<BookModel> books;

  UserLibraryModel({
    required this.id,
    required this.userId,
    required this.books,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '\$id': id,
      'user_id': userId,
      'books': books.map((x) => x.toJson()).toList(),
    };
  }

  factory UserLibraryModel.fromJson(Map<String, dynamic> json) {
    return UserLibraryModel(
      id: json['\$id'] as String,
      userId: json['user_id'] as String,
      books: (json['books'] as List<dynamic>)
          .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
