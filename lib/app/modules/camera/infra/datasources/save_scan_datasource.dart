import 'package:ml_nota_certa/app/modules/camera/domain/entities/scan_dto.dart';

abstract class ISaveScanDatasource {
  Future<void> call(ScanDTO dto);
}
