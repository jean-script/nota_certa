import 'package:ml_nota_certa/app/modules/camera/domain/entities/scan_dto.dart';

abstract class IGetScanStudentyDatasource {
  Future<List<ScanDTO>> call(String studentyId, String evalutionId);
}
