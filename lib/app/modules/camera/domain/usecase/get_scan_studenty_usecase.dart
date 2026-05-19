import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/entities/scan_dto.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/repositories/get_scan_studenty_repository.dart';

abstract class IGetScanStudentyUsecase {
  Future<Either<Exception, List<ScanDTO>>> call(
    String studentyId,
    String evalutionId,
  );
}

class GetScanStudentyUsecase extends IGetScanStudentyUsecase {
  final IGetScanStudentyRepository _repository;

  GetScanStudentyUsecase(this._repository);
  @override
  Future<Either<Exception,List<ScanDTO>>> call(
    String studentyId,
    String evalutionId,
  ) {
    return _repository(studentyId, evalutionId);
  }
}
