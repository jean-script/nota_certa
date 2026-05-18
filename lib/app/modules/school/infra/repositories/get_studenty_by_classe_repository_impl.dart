import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/studenty_dto.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/get_studenty_by_classe_repository.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/get_studenty_by_classe_datasource.dart';

class GetStudentyByClasseRepositoryImpl extends IGetStudentyByClasseRepository {
  final IGetStudentyByClasseDatasource _datasource;

  GetStudentyByClasseRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, List<StudentDTO>>> call(String classId) async {
    try {
      return Right(await _datasource(classId));
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
