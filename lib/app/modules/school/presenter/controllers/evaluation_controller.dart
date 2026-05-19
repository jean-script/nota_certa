import 'package:get/get.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/student_evaluation_answer_hive.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/studenty_dto.dart';
import 'package:ml_nota_certa/app/modules/school/domain/usecases/get_answer_by_studenty_evalution_usecase.dart';
import 'package:ml_nota_certa/app/modules/school/domain/usecases/save_studenty_answer_usecase.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/school_controller.dart';
import 'package:ml_nota_certa/app/utils/app_logger.dart';

class EvaluationController extends GetxController
    with StateMixin<List<StudentDTO>> {
  final ISaveStudentyAnswerUsecase _saveAnswerUsecase;
  final IGetAnswerByStudentyEvalutionUsecase
  _getAnswerByStudentyEvalutionUsecase;

  EvaluationController(
    this._saveAnswerUsecase,
    this._getAnswerByStudentyEvalutionUsecase,
  );

  final int totalQuestions = SchoolController.to.reviewSelected!.totalQuestions;

  /// studentId -> answers
  final Map<String, List<int?>> answers = {};

  @override
  void onInit() {
    AppLogger.log('[EVALUATION_CONTROLLER] -> onInit iniciado');
    _loadStudentsChange();
    super.onInit();
  }

  Future<void> loadStudents() async {
    AppLogger.log('[LOAD_STUDENTS] -> carregando estudantes');
    await _loadStudents();
  }

  Future<void> _loadStudentsChange() async {
    AppLogger.log('[LOAD_STUDENTS_CHANGE] -> alterando estado para loading');
    change(null, status: RxStatus.loading());

    await _loadStudents();
    AppLogger.log(
      '[LOAD_STUDENTS_CHANGE] -> estudantes carregados total ${students.length}',
    );
    change(
      students,
      status: students.isEmpty ? RxStatus.empty() : RxStatus.success(),
    );
  }

  Future<void> _loadStudents() async {
    AppLogger.log('[LOAD_STUDENTS] -> buscando estudantes da turma');

    await SchoolController.to.getStudentyByClasseUsecase();

    AppLogger.log('[LOAD_STUDENTS] -> carregando respostas salvas');

    await _loadSavedAnswers();
  }

  Future<void> _loadSavedAnswers() async {
    AppLogger.log('[LOAD_SAVED_ANSWERS] -> iniciando carregamento');

    for (final student in students) {
      AppLogger.log(
        '[LOAD_SAVED_ANSWERS] -> carregando respostas do aluno ${student.name}',
      );

      final localAnswer = await _getStudentAnswer(student.id);

      answers[student.id] = localAnswer?.answers ?? _emptyAnswers();

      AppLogger.log(
        '[LOAD_SAVED_ANSWERS] -> respostas carregadas aluno ${student.name}',
      );
    }

    AppLogger.log('[LOAD_SAVED_ANSWERS] -> finalizado');
  }

  Future<StudentEvaluationAnswerHive?> _getStudentAnswer(
    String studentId,
  ) async {
    AppLogger.log('[GET_STUDENT_ANSWER] -> buscando resposta aluno $studentId');

    final result = await _getAnswerByStudentyEvalutionUsecase(
      studentId,
      evaluationId,
    );

    return result.fold(
      (_) {
        AppLogger.log(
          '[GET_STUDENT_ANSWER] -> nenhuma resposta encontrada aluno $studentId',
        );

        return null;
      },
      (answer) {
        AppLogger.log(
          '[GET_STUDENT_ANSWER] -> resposta encontrada aluno $studentId',
        );

        return answer;
      },
    );
  }

  List<int?> _emptyAnswers() {
    return List.generate(totalQuestions, (_) => null);
  }

  void updateAnswer({
    required String studentId,
    required int questionIndex,
    required int? value,
  }) {
    AppLogger.log(
      '[UPDATE_ANSWER] -> aluno $studentId questão $questionIndex valor $value',
    );

    answers[studentId]?[questionIndex] = value;

    update(['student_$studentId']);
  }

  Future<void> saveAnswers() async {
    AppLogger.log('[SAVE_ANSWERS] -> iniciando salvamento geral');

    for (final student in students) {
      await saveStudentAnswer(student.id);
    }

    AppLogger.log('[SAVE_ANSWERS] -> respostas salvas com sucesso');

    Get.snackbar('Sucesso', 'Respostas salvas');
  }

  Future<void> saveStudentAnswer(String studentId) async {
    AppLogger.log('[SAVE_STUDENT_ANSWER] -> salvando aluno $studentId');

    try {
      final entity = _buildStudentAnswerEntity(studentId);

      await _saveAnswerUsecase(entity);

      AppLogger.log('[SAVE_STUDENT_ANSWER] -> sucesso aluno $studentId');
    } catch (e, s) {
      await AppLogger.error(e, s);

      AppLogger.log('[SAVE_STUDENT_ANSWER] -> erro aluno $studentId');
    }
  }

  StudentEvaluationAnswerHive _buildStudentAnswerEntity(String studentId) {
    AppLogger.log(
      '[BUILD_STUDENT_ENTITY] -> montando entidade aluno $studentId',
    );

    return StudentEvaluationAnswerHive(
      id: '${evaluationId}_$studentId',
      studentId: studentId,
      evaluationId: evaluationId,
      createdAt: DateTime.now(),
      grade: calculateStudentGrade(studentId),
      answers: answers[studentId],
    );
  }

  double? calculateStudentGrade(String studentId) {
    final review = SchoolController.to.reviewSelected;

    if (review == null) {
      AppLogger.log('[CALCULATE_GRADE] -> review nula aluno $studentId');

      return null;
    }

    final studentAnswers = answers[studentId];

    if (studentAnswers == null) {
      AppLogger.log('[CALCULATE_GRADE] -> respostas nulas aluno $studentId');

      return null;
    }

    final grade = calculateGrade(studentAnswers, review.answerKey);

    AppLogger.log(
      '[CALCULATE_GRADE] -> nota calculada aluno $studentId nota $grade',
    );

    return grade;
  }

  double calculateGrade(List<int?> answers, List<int> answerKey) {
    int correct = 0;

    for (int i = 0; i < answerKey.length; i++) {
      if (answers[i] == answerKey[i]) {
        correct++;
      }
    }

    return correct.toDouble();
  }

  bool isStudentCompleted(String studentId) {
    final studentAnswers = answers[studentId];

    if (studentAnswers == null) {
      return false;
    }

    return studentAnswers.every((answer) => answer != null);
  }

  int totalAnswered(String studentId) {
    final studentAnswers = answers[studentId];

    if (studentAnswers == null) {
      return 0;
    }

    return studentAnswers.where((answer) => answer != null).length;
  }

  List<int?> getStudentAnswers(String studentId) {
    return answers[studentId] ?? [];
  }

  List<StudentDTO> get students => SchoolController.to.students;

  String get evaluationId => SchoolController.to.reviewSelected!.id;

  static EvaluationController get to => Get.find<EvaluationController>();
}
