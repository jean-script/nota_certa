import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/classes_dto.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/get_classes_by_school_repository.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/get_classes_by_school_datasource.dart';

class GetClassesBySchoolRepositoryImpl extends IGetClassesBySchoolRepository {
  final IGetClassesBySchoolDatasource _datasource;

  GetClassesBySchoolRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, List<ClassDTO>>> call(String schoolId) async {
    try {
      return Right(await _datasource(schoolId));
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
