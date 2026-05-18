import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/student_evaluation_answer_hive.dart';

abstract class IGetAnswerByStudentyEvalutionRepository {
  Future<Either<Exception, StudentEvaluationAnswerHive?>> call(
    String studentyId,
    String evalutionId,
  );
}
