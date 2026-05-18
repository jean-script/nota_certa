import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/classes_dto.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/get_classes_by_school_repository.dart';

abstract class IGetClassesBySchoolUsecase {
  Future<Either<Exception, List<ClassDTO>>> call(String schoolId);
}

class GetClassesBySchoolUsecase extends IGetClassesBySchoolUsecase {
  final IGetClassesBySchoolRepository _repository;

  GetClassesBySchoolUsecase(this._repository);
  @override
  Future<Either<Exception, List<ClassDTO>>> call(String schoolId) async {
    return _repository(schoolId);
  }
}
