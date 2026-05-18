import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/student_evaluation_answer_hive.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/get_answer_by_studenty_evalution_repository.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/get_answer_studenty_evalution_datasource.dart';

class GetAnswerByStudentyEvalutionRepositoryImpl
    extends IGetAnswerByStudentyEvalutionRepository {
  final IGetAnswerStudentyEvalutionDatasource _datasource;

  GetAnswerByStudentyEvalutionRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, StudentEvaluationAnswerHive?>> call(
    String studentyId,
    String evalutionId,
  ) async {
    try {
      return Right(await _datasource(studentyId, evalutionId));
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
