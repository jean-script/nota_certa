import 'package:hive/hive.dart';

part 'scan_dto.g.dart';

@HiveType(typeId: 1)
class ScanDTO extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String studentId;

  @HiveField(2)
  String evaluationId;

  @HiveField(3)
  String? imagePath;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  double? grade;

  @HiveField(6)
  List<int?>? detectedAnswers;

  ScanDTO({
    required this.id,
    required this.studentId,
    required this.evaluationId,
    this.imagePath,
    required this.createdAt,
    this.grade,
    this.detectedAnswers,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentId': studentId,
      'evaluationId': evaluationId,
      'imagePath': imagePath,
      'createdAt': createdAt,
      'grade': grade,
      'detectedAnswers': detectedAnswers,
    };
  }
}
