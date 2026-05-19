import 'package:get/get.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/repositories/get_scan_studenty_repository.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/usecase/get_scan_studenty_usecase.dart';
import 'package:ml_nota_certa/app/modules/camera/external/get_scan_studenty_datasource_impl.dart';
import 'package:ml_nota_certa/app/modules/camera/infra/datasources/get_scan_studenty_datasource.dart';
import 'package:ml_nota_certa/app/modules/camera/infra/repositories/get_scan_studenty_repository_impl.dart';

class StudentyBindings extends Bindings {
  @override
  void dependencies() {
    // get scan
    Get.lazyPut<IGetScanStudentyDatasource>(
      () => GetScanStudentyDatasourceImpl(),
    );
    Get.lazyPut<IGetScanStudentyRepository>(
      () => GetScanStudentyRepositoryImpl(Get.find()),
    );
    Get.lazyPut<IGetScanStudentyUsecase>(
      () => GetScanStudentyUsecase(Get.find()),
    );
  }
}
