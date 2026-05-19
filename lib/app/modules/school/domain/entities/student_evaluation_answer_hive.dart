import 'package:hive/hive.dart';

part 'student_evaluation_answer_hive.g.dart';

@HiveType(typeId: 0)
class StudentEvaluationAnswerHive extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String studentId;

  @HiveField(2)
  String evaluationId;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  double? grade;

  @HiveField(6)
  List<int?>? answers;

  StudentEvaluationAnswerHive({
    required this.id,
    required this.studentId,
    required this.evaluationId,
    required this.createdAt,
    this.grade,
    this.answers,
  });
}
