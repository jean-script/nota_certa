import 'package:hive_flutter/adapters.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/entities/scan_dto.dart';
import 'package:ml_nota_certa/app/modules/camera/infra/datasources/save_scan_datasource.dart';
import 'package:ml_nota_certa/app/utils/app_logger.dart';

class SaveScanDatasourceImpl extends ISaveScanDatasource {
  @override
  Future<void> call(ScanDTO dto) async {
    try {
      AppLogger.log('salvando scan ${dto.toMap()}');
      final box = Hive.box<ScanDTO>('scans');

      await box.put(dto.id, dto);
    } catch (e, s) {
      AppLogger.log('Error ao salvar scan ${dto.id}');
      AppLogger.error(e, s);
      rethrow;
    }
  }
}
