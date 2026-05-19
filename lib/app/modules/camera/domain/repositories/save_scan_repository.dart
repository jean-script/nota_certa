import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/entities/scan_dto.dart';

abstract class ISaveScanRepository {
  Future<Either<Exception, void>> call(ScanDTO dto);
}
