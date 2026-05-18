import 'package:ml_nota_certa/app/modules/school/domain/entities/student_evaluation_answer_hive.dart';

abstract class IGetAnswerStudentyEvalutionDatasource {
  Future<StudentEvaluationAnswerHive?> call(
    String studentyId,
    String evalutionId,
  );
}
