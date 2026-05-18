import 'package:get/get.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/get_classes_by_school_repository.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/get_reviews_by_classes_usecase.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/get_school_repository.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/get_studenty_by_classe_repository.dart';

import 'package:ml_nota_certa/app/modules/school/domain/usecases/get_classes_by_school_usecase.dart';
import 'package:ml_nota_certa/app/modules/school/domain/usecases/get_reviews_by_classes_usecase.dart';
import 'package:ml_nota_certa/app/modules/school/domain/usecases/get_school_usecase.dart';
import 'package:ml_nota_certa/app/modules/school/domain/usecases/get_studenty_by_classe_usecase.dart';
import 'package:ml_nota_certa/app/modules/school/external/get_classes_by_school_datasource_impl.dart';
import 'package:ml_nota_certa/app/modules/school/external/get_review_by_classe_datasource_impl.dart';
import 'package:ml_nota_certa/app/modules/school/external/get_school_datasource_impl.dart';
import 'package:ml_nota_certa/app/modules/school/external/get_studenty_by_classe_datasource_impl.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/get_classes_by_school_datasource.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/get_reviews_by_classes_datasource.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/get_school_datasource.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/get_studenty_by_classe_datasource.dart';
import 'package:ml_nota_certa/app/modules/school/infra/repositories/get_classes_by_school_repository_impl.dart';
import 'package:ml_nota_certa/app/modules/school/infra/repositories/get_review_by_classes_repository_impl.dart';
import 'package:ml_nota_certa/app/modules/school/infra/repositories/get_school_repository_impl.dart';
import 'package:ml_nota_certa/app/modules/school/infra/repositories/get_studenty_by_classe_repository_impl.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/school_controller.dart';

class SchoolBindings extends Bindings {
  @override
  void dependencies() {
    // get schools
    Get.lazyPut<IGetSchoolDatasource>(() => GetSchoolDatasourceImpl());
    Get.lazyPut<IGetSchoolRepository>(
      () => GetSchoolRepositoryImpl(Get.find()),
    );
    Get.lazyPut<IGetSchoolUsecase>(() => GetSchoolUsecase(Get.find()));

    // get class by school
    Get.lazyPut<IGetClassesBySchoolDatasource>(
      () => GetClassesBySchoolDatasourceImpl(),
    );
    Get.lazyPut<IGetClassesBySchoolRepository>(
      () => GetClassesBySchoolRepositoryImpl(Get.find()),
    );
    Get.lazyPut<IGetClassesBySchoolUsecase>(
      () => GetClassesBySchoolUsecase(Get.find()),
    );

    // get studenty by classe
    Get.lazyPut<IGetStudentyByClasseDatasource>(
      () => GetStudentyByClasseDatasourceImpl(),
    );
    Get.lazyPut<IGetStudentyByClasseRepository>(
      () => GetStudentyByClasseRepositoryImpl(Get.find()),
    );
    Get.lazyPut<IGetStudentyByClasseUsecase>(
      () => GetStudentyByClasseUsecase(Get.find()),
    );

    // get review by classes
    Get.lazyPut<IGetReviewsByClassesDatasource>(
      () => GetReviewByClasseDatasourceImpl(),
    );
    Get.lazyPut<IGetReviewsByClassesRepository>(
      () => GetReviewByClassesRepositoryImpl(Get.find()),
    );
    Get.lazyPut<IGetReviewsByClassesUsecase>(
      () => GetReviewsByClassesUsecase(Get.find()),
    );
    // controller
    Get.put(
      SchoolController(Get.find(), Get.find(), Get.find(), Get.find()),
      permanent: true,
    );
  }
}
