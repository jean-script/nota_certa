import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/studenty_dto.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/get_studenty_by_classe_repository.dart';

abstract class IGetStudentyByClasseUsecase {
  Future<Either<Exception, List<StudentDTO>>> call(String classId);
}

class GetStudentyByClasseUsecase extends IGetStudentyByClasseUsecase {
  final IGetStudentyByClasseRepository _repository;

  GetStudentyByClasseUsecase(this._repository);
  @override
  Future<Either<Exception, List<StudentDTO>>> call(String classId) {
    return _repository(classId);
  }
}
