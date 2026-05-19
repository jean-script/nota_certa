import 'package:get/get.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/entities/scan_dto.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/usecase/get_scan_studenty_usecase.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/studenty_dto.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/evaluation_controller.dart';
import 'package:ml_nota_certa/app/utils/app_logger.dart';

class StudentController extends GetxController with StateMixin {
  final IGetScanStudentyUsecase _getScanStudentyUsecase;

  final scans = <ScanDTO>[].obs;
  final StudentDTO student;

  StudentController(this._getScanStudentyUsecase, {required this.student});

  @override
  void onInit() {
    getScansStudent();
    super.onInit();
  }

  void getScansStudent() async {
    AppLogger.log('[GET SCAN STUDENTY] -> iniciando buscar por gabaritos');
    change(null, status: RxStatus.loading());

    final result = await _getScanStudentyUsecase(
      student.id,
      EvaluationController.to.evaluationId,
    );

    result.fold(
      (fail) {
        AppLogger.log(
          '[GET SCAN STUDENTY] -> erro ao obter scann ${fail.toString()}',
        );
        change(null, status: RxStatus.error());
      },
      (list) {
        AppLogger.log('[GET SCHOOL] -> sucesso ao obter escolas!');
        scans.value = list;
        if (scans.isEmpty) {
          AppLogger.log('[GET SCHOOL] -> sem escolas');
          change(null, status: RxStatus.empty());
          return;
        }
        change(scans, status: RxStatus.success());
      },
    );
  }

  static StudentController get to => Get.find();
}
