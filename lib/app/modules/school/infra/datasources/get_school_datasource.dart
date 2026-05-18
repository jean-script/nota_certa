import 'package:ml_nota_certa/app/modules/school/domain/entities/school_dto.dart';

abstract class IGetSchoolDatasource {
  Future<List<SchoolDTO>> call();
}
