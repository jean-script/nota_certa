import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/school_dto.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/get_school_repository.dart';

abstract class IGetSchoolUsecase {
  Future<Either<Exception, List<SchoolDTO>>> call();
}

class GetSchoolUsecase extends IGetSchoolUsecase {
  final IGetSchoolRepository _repository;

  GetSchoolUsecase(this._repository);
  @override
  Future<Either<Exception, List<SchoolDTO>>> call() {
    return _repository();
  }
}
