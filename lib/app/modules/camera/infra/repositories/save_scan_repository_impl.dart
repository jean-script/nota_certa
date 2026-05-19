import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/entities/scan_dto.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/repositories/save_scan_repository.dart';
import 'package:ml_nota_certa/app/modules/camera/infra/datasources/save_scan_datasource.dart';

class SaveScanRepositoryImpl extends ISaveScanRepository {
  final ISaveScanDatasource _datasource;

  SaveScanRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, void>> call(ScanDTO dto) async {
    try {
      return Right(await _datasource(dto));
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
