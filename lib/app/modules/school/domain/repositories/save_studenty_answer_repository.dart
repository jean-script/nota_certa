import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/student_evaluation_answer_hive.dart';

abstract class ISaveStudentyAnswerRepository {
  Future<Either<Exception, void>> call(StudentEvaluationAnswerHive dto);
}
