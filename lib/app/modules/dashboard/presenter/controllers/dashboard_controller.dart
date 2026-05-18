import 'package:get/get.dart';
import 'package:ml_nota_certa/app/modules/dashboard/domain/entities/question_error_dto.dart';
import 'package:ml_nota_certa/app/modules/dashboard/domain/entities/student_ranking_dto.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/student_evaluation_answer_hive.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/evaluation_controller.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/school_controller.dart';
import 'package:ml_nota_certa/app/services/pdf_service.dart';
import 'package:ml_nota_certa/app/utils/app_logger.dart';

class DashboardController extends GetxController
    with StateMixin<List<StudentEvaluationAnswerHive>> {
  final EvaluationController evaluationController;
  final PdfService _pdfService;

  DashboardController(this.evaluationController, this._pdfService);

  final RxDouble averageGrade = 0.0.obs;
  final RxDouble highestGrade = 0.0.obs;
  final RxDouble lowestGrade = 0.0.obs;

  final RxInt totalStudents = 0.obs;
  final RxInt completedStudents = 0.obs;
  final RxInt pendingStudents = 0.obs;

  final RxList<StudentRankingDTO> ranking = <StudentRankingDTO>[].obs;

  final RxMap<int, int> errorsPerQuestion = <int, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    AppLogger.log('[LOAD DASHBOARD] -> obtendo dados');
    change(null, status: RxStatus.loading());

    final review = SchoolController.to.reviewSelected!;
    await evaluationController.loadStudents();
    AppLogger.log('[LOAD DASHBOARD] -> estudantes obtidos ');

    final students = SchoolController.to.students;

    totalStudents.value = students.length;

    final List<StudentRankingDTO> rankingTemp = [];

    double totalGrades = 0;

    double highest = 0;
    double lowest = 999;

    int completed = 0;

    final Map<int, int> questionErrors = {};

    for (int i = 0; i < review.answerKey.length; i++) {
      questionErrors[i] = 0;
    }

    for (final student in students) {
      final answers = evaluationController.getStudentAnswers(student.id);

      final completedAnswers = answers.where((e) => e != null).length;

      if (completedAnswers > 0) {
        completed++;
      }

      final grade = evaluationController.calculateGrade(
        answers,
        review.answerKey,
      );

      totalGrades += grade;

      if (grade > highest) {
        highest = grade;
      }

      if (grade < lowest) {
        lowest = grade;
      }

      rankingTemp.add(
        StudentRankingDTO(
          studentName: student.name,
          grade: grade,
          answers: answers,
        ),
      );

      for (int i = 0; i < review.answerKey.length; i++) {
        if (answers[i] != review.answerKey[i]) {
          questionErrors[i] = (questionErrors[i] ?? 0) + 1;
        }
      }
    }

    rankingTemp.sort((a, b) => b.grade.compareTo(a.grade));

    averageGrade.value = students.isEmpty ? 0 : totalGrades / students.length;

    highestGrade.value = highest;

    lowestGrade.value = lowest == 999 ? 0 : lowest;

    completedStudents.value = completed;

    pendingStudents.value = students.length - completed;

    ranking.assignAll(rankingTemp);

    errorsPerQuestion.assignAll(questionErrors);

    change([], status: RxStatus.success());
  }

  Future<void> exportPdf() async {
    await _pdfService.generate(this);
  }

  List<QuestionErrorDTO> get mostWrongQuestions {
    final review = SchoolController.to.reviewSelected;

    if (review == null) {
      return [];
    }

    final result = <QuestionErrorDTO>[];

    for (int i = 0; i < review.answerKey.length; i++) {
      int wrong = 0;
      int answered = 0;

      for (final rankingStudent in ranking) {
        final answers = rankingStudent.answers;

        if (answers.length <= i) {
          continue;
        }

        final answer = answers[i];

        if (answer == null) {
          continue;
        }

        answered++;

        if (answer != review.answerKey[i]) {
          wrong++;
        }
      }

      final percent = answered == 0 ? 0 : (wrong / answered) * 100;

      result.add(
        QuestionErrorDTO(question: i + 1, errorPercent: percent.toDouble()),
      );
    }

    result.sort((a, b) => b.errorPercent.compareTo(a.errorPercent));

    return result.toList();
  }

  double get correctionProgress {
    final total = SchoolController.to.students.length;

    if (total == 0) {
      return 0;
    }

    return completedStudents.value / total;
  }
}
