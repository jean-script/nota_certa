import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/entities/scan_dto.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/repositories/save_scan_repository.dart';

abstract class ISaveScanUsecase {
  Future<Either<Exception, void>> call(ScanDTO dto);
}

class SaveScanUsecase extends ISaveScanUsecase {
  final ISaveScanRepository _repository;

  SaveScanUsecase(this._repository);
  @override
  Future<Either<Exception, void>> call(ScanDTO dto) {
    return _repository(dto);
  }
}
