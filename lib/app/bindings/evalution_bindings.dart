import 'package:get/get.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/get_answer_by_studenty_evalution_repository.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/save_studenty_answer_repository.dart';
import 'package:ml_nota_certa/app/modules/school/domain/usecases/get_answer_by_studenty_evalution_usecase.dart';
import 'package:ml_nota_certa/app/modules/school/domain/usecases/save_studenty_answer_usecase.dart';
import 'package:ml_nota_certa/app/modules/school/external/get_answer_studenty_evalution_datasource_impl.dart';
import 'package:ml_nota_certa/app/modules/school/external/save_studenty_answer_datasource_impl.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/get_answer_studenty_evalution_datasource.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/save_studenty_answer_datasource.dart';
import 'package:ml_nota_certa/app/modules/school/infra/repositories/get_answer_by_studenty_evalution_repository_impl.dart';
import 'package:ml_nota_certa/app/modules/school/infra/repositories/save_studenty_answer_repository_impl.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/evaluation_controller.dart';

class EvalutionBindings extends Bindings {
  @override
  void dependencies() {
    // get studenty answer
    Get.lazyPut<IGetAnswerStudentyEvalutionDatasource>(
      () => GetAnswerStudentyEvalutionDatasourceImpl(),
    );
    Get.lazyPut<IGetAnswerByStudentyEvalutionRepository>(
      () => GetAnswerByStudentyEvalutionRepositoryImpl(Get.find()),
    );
    Get.lazyPut<IGetAnswerByStudentyEvalutionUsecase>(
      () => GetAnswerByStudentyEvalutionUsecase(Get.find()),
    );
    // save studenty answer
    Get.lazyPut<ISaveStudentyAnswerDatasource>(
      () => SaveStudentyAnswerDatasourceImpl(),
    );
    Get.lazyPut<ISaveStudentyAnswerRepository>(
      () => SaveStudentyAnswerRepositoryImpl(Get.find()),
    );
    Get.lazyPut<ISaveStudentyAnswerUsecase>(
      () => SaveStudentyAnswerUsecase(Get.find()),
    );

    Get.lazyPut(() => EvaluationController(Get.find(), Get.find()));
  }
}
