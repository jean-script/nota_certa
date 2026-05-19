import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/entities/scan_dto.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/repositories/get_scan_studenty_repository.dart';
import 'package:ml_nota_certa/app/modules/camera/infra/datasources/get_scan_studenty_datasource.dart';

class GetScanStudentyRepositoryImpl extends IGetScanStudentyRepository {
  final IGetScanStudentyDatasource _datasource;

  GetScanStudentyRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, List<ScanDTO>>> call(
    String studentyId,
    String evalutionId,
  ) async {
    try {
      return Right(await _datasource(studentyId, evalutionId));
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
