class Submission {
  final String id;
  final String assignmentId;
  final String studentId;
  final String content;
  final List<String>? attachmentUrls;
  final DateTime submittedAt;
  final int? score;
  final String? feedback;
  final DateTime? gradedAt;
  final String status;

  Submission({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    required this.content,
    this.attachmentUrls,
    required this.submittedAt,
    this.score,
    this.feedback,
    this.gradedAt,
    this.status = 'submitted',
  });

  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      id: json['id'] as String,
      assignmentId: json['assignmentId'] as String,
      studentId: json['studentId'] as String,
      content: json['content'] as String,
      attachmentUrls: List<String>.from(json['attachmentUrls'] as List? ?? []),
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      score: json['score'] as int?,
      feedback: json['feedback'] as String?,
      gradedAt: json['gradedAt'] != null ? DateTime.parse(json['gradedAt'] as String) : null,
      status: json['status'] as String? ?? 'submitted',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'assignmentId': assignmentId,
      'studentId': studentId,
      'content': content,
      'attachmentUrls': attachmentUrls,
      'submittedAt': submittedAt.toIso8601String(),
      'score': score,
      'feedback': feedback,
      'gradedAt': gradedAt?.toIso8601String(),
      'status': status,
    };
  }
}
