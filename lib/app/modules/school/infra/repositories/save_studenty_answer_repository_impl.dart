import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/student_evaluation_answer_hive.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/save_studenty_answer_repository.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/save_studenty_answer_datasource.dart';

class SaveStudentyAnswerRepositoryImpl extends ISaveStudentyAnswerRepository {
  final ISaveStudentyAnswerDatasource _datasource;

  SaveStudentyAnswerRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, void>> call(StudentEvaluationAnswerHive dto) async {
    try {
      return Right(await _datasource(dto));
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
