import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/student_evaluation_answer_hive.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/get_answer_by_studenty_evalution_repository.dart';

abstract class IGetAnswerByStudentyEvalutionUsecase {
  Future<Either<Exception,StudentEvaluationAnswerHive?>> call(
    String studentyId,
    String evalutionId,
  );
}

class GetAnswerByStudentyEvalutionUsecase
    extends IGetAnswerByStudentyEvalutionUsecase {
  final IGetAnswerByStudentyEvalutionRepository _repository;

  GetAnswerByStudentyEvalutionUsecase(this._repository);
  @override
  Future<Either<Exception, StudentEvaluationAnswerHive?>> call(
    String studentyId,
    String evalutionId,
  ) async {
    return _repository(studentyId, evalutionId);
  }
}
