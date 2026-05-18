import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/classes_dto.dart';

abstract class IGetClassesBySchoolRepository {
  Future<Either<Exception, List<ClassDTO>>> call(String schoolId);
}
