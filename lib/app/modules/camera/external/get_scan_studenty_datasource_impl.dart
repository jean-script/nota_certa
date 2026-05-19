import 'package:hive/hive.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/entities/scan_dto.dart';
import 'package:ml_nota_certa/app/modules/camera/infra/datasources/get_scan_studenty_datasource.dart';

class GetScanStudentyDatasourceImpl extends IGetScanStudentyDatasource {
  @override
  Future<List<ScanDTO>> call(String studentyId, String evalutionId) async {
    final box = Hive.box<ScanDTO>('scans');

    try {
      return box.values
          .where(
            (scan) =>
                scan.studentId == studentyId &&
                scan.evaluationId == evalutionId,
          )
          .toList();
    } on Exception catch (_) {
      // AppLogger.error(e, s);
      return [];
    }
  }
}
