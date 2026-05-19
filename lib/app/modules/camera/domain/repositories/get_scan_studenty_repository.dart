import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/entities/scan_dto.dart';

abstract class IGetScanStudentyRepository {
  Future<Either<Exception, List<ScanDTO>>> call(
    String studentyId,
    String evalutionId,
  );
}
