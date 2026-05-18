import 'package:get/get.dart';
import 'package:ml_nota_certa/app/modules/dashboard/presenter/controllers/dashboard_controller.dart';
import 'package:ml_nota_certa/app/services/pdf_service.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PdfService());
    Get.lazyPut(() => DashboardController(Get.find(), Get.find()));
  }
}
