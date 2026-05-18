
import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/studenty_dto.dart';

abstract class IGetStudentyByClasseRepository {
  Future<Either<Exception, List<StudentDTO>>> call(String classId);
}