class Review {
  final String id;
  final String courseId;
  final String userId;
  final double rating;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int helpfulCount;

  Review({
    required this.id,
    required this.courseId,
    required this.userId,
    required this.rating,
    required this.title,
    required this.content,
    required this.createdAt,
    this.updatedAt,
    this.helpfulCount = 0,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      userId: json['userId'] as String,
      rating: (json['rating'] as num).toDouble(),
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
      helpfulCount: json['helpfulCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'userId': userId,
      'rating': rating,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'helpfulCount': helpfulCount,
    };
  }
}
