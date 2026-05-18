import 'package:hive/hive.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/student_evaluation_answer_hive.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/get_answer_studenty_evalution_datasource.dart';

class GetAnswerStudentyEvalutionDatasourceImpl
    extends IGetAnswerStudentyEvalutionDatasource {
  @override
  Future<StudentEvaluationAnswerHive?> call(
    String studentyId,
    String evalutionId,
  ) async {
    final box = Hive.box<StudentEvaluationAnswerHive>('student_answers');

    final key = '${evalutionId}_$studentyId';

    final result = box.get(key);

    return result;
  }
}
