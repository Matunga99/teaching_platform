class Course {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final String thumbnail;
  final List<String> lessons;
  final DateTime createdAt;
  final bool isCompleted;
  final double progress;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.thumbnail,
    required this.lessons,
    required this.createdAt,
    this.isCompleted = false,
    this.progress = 0.0,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      instructor: json['instructor'] as String,
      thumbnail: json['thumbnail'] as String,
      lessons: List<String>.from(json['lessons'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'instructor': instructor,
      'thumbnail': thumbnail,
      'lessons': lessons,
      'createdAt': createdAt.toIso8601String(),
      'isCompleted': isCompleted,
      'progress': progress,
    };
  }
}
