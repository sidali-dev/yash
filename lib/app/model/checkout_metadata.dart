class CheckoutMetadata {
  final List<String> bookId;
  final String userId;

  CheckoutMetadata({required this.bookId, required this.userId});

  factory CheckoutMetadata.fromJson(Map<String, dynamic> json) {
    return CheckoutMetadata(
      bookId: List<String>.from(json['book_id']),
      userId: json['user_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'book_id': bookId, 'user_id': userId};
  }
}
