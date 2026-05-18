class ReviewDTO {
  final String id;
  final String classroomId;
  final String title;
  final DateTime applicationDate;
  final int totalQuestions;
  final List<int> answerKey;

  ReviewDTO({
    required this.id,
    required this.classroomId,
    required this.title,
    required this.applicationDate,
    required this.totalQuestions,
    required this.answerKey,
  });

  factory ReviewDTO.fromJson(Map<String, dynamic> json) {
    return ReviewDTO(
      id: json['id'] ,
      classroomId: json['turma_id'] ,
      title: json['titulo'] ,
      applicationDate: DateTime.parse(
        json['data_aplicacao'],
      ),
      totalQuestions: json['total_questoes'] ,
      answerKey: List<int>.from(json['gabarito'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'turma_id': classroomId,
      'titulo': title,
      'data_aplicacao': applicationDate.toIso8601String(),
      'total_questoes': totalQuestions,
      'gabarito': answerKey,
    };
  }

  ReviewDTO copyWith({
    String? id,
    String? classroomId,
    String? title,
    DateTime? applicationDate,
    int? totalQuestions,
    List<int>? answerKey,
  }) {
    return ReviewDTO(
      id: id ?? this.id,
      classroomId: classroomId ?? this.classroomId,
      title: title ?? this.title,
      applicationDate: applicationDate ?? this.applicationDate,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      answerKey: answerKey ?? this.answerKey,
    );
  }
}