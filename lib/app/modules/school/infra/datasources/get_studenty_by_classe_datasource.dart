import 'package:ml_nota_certa/app/modules/school/domain/entities/studenty_dto.dart';

abstract class IGetStudentyByClasseDatasource {
  Future<List<StudentDTO>> call(String classId);
}
