import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/student_evaluation_answer_hive.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/save_studenty_answer_repository.dart';

abstract class ISaveStudentyAnswerUsecase {
  Future<Either<Exception, void>> call(StudentEvaluationAnswerHive dto);
}

class SaveStudentyAnswerUsecase extends ISaveStudentyAnswerUsecase {
  final ISaveStudentyAnswerRepository _repository;

  SaveStudentyAnswerUsecase(this._repository);
  @override
  Future<Either<Exception, void>> call(StudentEvaluationAnswerHive dto) {
    return _repository(dto);
  }
}
