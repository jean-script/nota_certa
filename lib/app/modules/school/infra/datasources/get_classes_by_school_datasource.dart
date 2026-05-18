import 'package:ml_nota_certa/app/modules/school/domain/entities/classes_dto.dart';

abstract class IGetClassesBySchoolDatasource {
  Future<List<ClassDTO>> call(String schoolId);
}
