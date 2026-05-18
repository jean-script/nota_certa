class StudentRankingDTO {
  final String studentName;
  final double grade;
  final List<int?> answers;

  StudentRankingDTO({
    required this.studentName,
    required this.grade,
    required this.answers,
  });
}
