class Lesson {
  final String id;
  final String courseId;
  final String title;
  final String content;
  final String videoUrl;
  final Duration duration;
  final DateTime createdAt;
  final bool isCompleted;
  final DateTime? completedAt;

  Lesson({
    required this.id,
    required this.courseId,
    required this.title,
    required this.content,
    required this.videoUrl,
    required this.duration,
    required this.createdAt,
    this.isCompleted = false,
    this.completedAt,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      videoUrl: json['videoUrl'] as String,
      duration: Duration(seconds: json['duration'] as int? ?? 0),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'content': content,
      'videoUrl': videoUrl,
      'duration': duration.inSeconds,
      'createdAt': createdAt.toIso8601String(),
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
    };
  }
}
