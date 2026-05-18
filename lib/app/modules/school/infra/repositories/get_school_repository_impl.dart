import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/school_dto.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/get_school_repository.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/get_school_datasource.dart';

class GetSchoolRepositoryImpl extends IGetSchoolRepository {
  final IGetSchoolDatasource _datasource;

  GetSchoolRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, List<SchoolDTO>>> call() async {
    try {
      return Right(await _datasource());
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
