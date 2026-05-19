import 'package:get/get.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/repositories/save_scan_repository.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/usecase/save_scan_usecase.dart';
import 'package:ml_nota_certa/app/modules/camera/external/save_scan_datasource_impl.dart';
import 'package:ml_nota_certa/app/modules/camera/infra/datasources/save_scan_datasource.dart';
import 'package:ml_nota_certa/app/modules/camera/infra/repositories/save_scan_repository_impl.dart';
import 'package:ml_nota_certa/app/modules/camera/presenter/controllers/camera_controller.dart';

class CameraBindings extends Bindings {
  @override
  void dependencies() {
    // save scan
    Get.lazyPut<ISaveScanDatasource>(() => SaveScanDatasourceImpl());
    Get.lazyPut<ISaveScanRepository>(() => SaveScanRepositoryImpl(Get.find()));
    Get.lazyPut<ISaveScanUsecase>(() => SaveScanUsecase(Get.find()));

    Get.put(MyCameraController(Get.find()), permanent: true);
  }
}
