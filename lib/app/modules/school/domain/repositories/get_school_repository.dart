import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/school_dto.dart';

abstract class IGetSchoolRepository {
  Future<Either<Exception, List<SchoolDTO>>> call();
}
