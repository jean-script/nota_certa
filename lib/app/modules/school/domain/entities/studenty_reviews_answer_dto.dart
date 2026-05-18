class StudentEvaluationAnswerDTO {
  final String id;
  final String studentId;
  final String evaluationId;
  final String? imagePath;
  final DateTime createdAt;
  final double? grade;
  final List<int?>? detectedAnswers;

  StudentEvaluationAnswerDTO({
    required this.id,
    required this.studentId,
    required this.evaluationId,
    this.imagePath,
    required this.createdAt,
    this.grade,
    this.detectedAnswers,
  });

  factory StudentEvaluationAnswerDTO.fromMap(Map<String, dynamic> map) {
    return StudentEvaluationAnswerDTO(
      id: map['id'],
      studentId: map['aluno_id'],
      evaluationId: map['avaliacao_id'],
      imagePath: map['imagem_path'],
      createdAt: DateTime.parse(map['data_hora']),
      grade: map['nota']?.toDouble(),
      detectedAnswers: map['respostas_detectadas'] != null
          ? List<int?>.from(map['respostas_detectadas'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'aluno_id': studentId,
      'avaliacao_id': evaluationId,
      'imagem_path': imagePath,
      'data_hora': createdAt.toIso8601String(),
      'nota': grade,
      'respostas_detectadas': detectedAnswers,
    };
  }
}
