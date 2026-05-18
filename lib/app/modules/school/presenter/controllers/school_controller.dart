// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/classes_dto.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/reviews_dto.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/school_dto.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/studenty_dto.dart';
import 'package:ml_nota_certa/app/modules/school/domain/usecases/get_classes_by_school_usecase.dart';
import 'package:ml_nota_certa/app/modules/school/domain/usecases/get_reviews_by_classes_usecase.dart';
import 'package:ml_nota_certa/app/modules/school/domain/usecases/get_school_usecase.dart';
import 'package:ml_nota_certa/app/modules/school/domain/usecases/get_studenty_by_classe_usecase.dart';
import 'package:ml_nota_certa/app/utils/app_logger.dart';

class SchoolController extends GetxController with StateMixin {
  final IGetSchoolUsecase _getSchoolUsecase;
  final IGetClassesBySchoolUsecase _classesBySchoolUsecase;
  final IGetStudentyByClasseUsecase _getStudentyByClasseUsecase;
  final IGetReviewsByClassesUsecase _getReviewsByClassesUsecase;

  final _schools = <SchoolDTO>[].obs;
  final _classes = <ClassDTO>[].obs;
  final _students = <StudentDTO>[].obs;
  final _reviews = <ReviewDTO>[].obs;
  SchoolDTO? schoolSelected;
  ClassDTO? classSelected;
  ReviewDTO? reviewSelected;

  final TextEditingController searchController = TextEditingController();

  SchoolController(
    this._getSchoolUsecase,
    this._classesBySchoolUsecase,
    this._getStudentyByClasseUsecase,
    this._getReviewsByClassesUsecase,
  );

  @override
  void onInit() {
    getSchool();
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void getSchool() async {
    AppLogger.log('[GET SCHOOL] -> iniciando buscar por escolas');
    change(null, status: RxStatus.loading());

    final result = await _getSchoolUsecase();

    result.fold(
      (fail) {
        AppLogger.log(
          '[GET SCHOOL] -> erro ao obter as escolas ${fail.toString()}',
        );
        change(null, status: RxStatus.error());
      },
      (schoolRes) {
        AppLogger.log('[GET SCHOOL] -> sucesso ao obter escolas!');
        _schools.value = schoolRes;
        if (schoolRes.isEmpty) {
          AppLogger.log('[GET SCHOOL] -> sem escolas');
          change(schoolRes, status: RxStatus.empty());
          return;
        }
        change(schoolRes, status: RxStatus.success());
      },
    );
  }

  void getClassesBySchool(RxBool loading) async {
    AppLogger.log(
      '[GET CLASSES BY SCHOOL] -> iniciando busca por classe da escola ${schoolSelected!.id}',
    );
    loading.value = true;
    final result = await _classesBySchoolUsecase(schoolSelected!.id);

    result.fold(
      (fail) {
        AppLogger.log(
          '[GET CLASSES BY SCHOOL] -> erro ao obter as classes ${fail.toString()}',
        );
      },
      (clas) {
        AppLogger.log('[GET CLASSES BY SCHOOL] ->  sucesso ao obter classes!');
        _classes.value = clas;
      },
    );
    loading.value = false;
  }

  Future<void> getStudentyByClasseUsecase() async {
    AppLogger.log(
      '[GET STUDENTY BY CLASSE] -> iniciando busca por estudantes da classe ${classSelected!.id}',
    );
    final result = await _getStudentyByClasseUsecase(classSelected!.id);

    await result.fold(
      (fail) {
        AppLogger.log(
          '[GET STUDENTY BY CLASSE] -> erro ao obter as classes ${fail.toString()}',
        );
      },
      (students) {
        AppLogger.log(
          '[GET STUDENTY BY CLASSE] -> sucesso ao obter estudantes da turma ${classSelected!.name}',
        );
        _students.value = students;
      },
    );
  }

  void getReviewsByClassesUsecase(RxBool loading) async {
    AppLogger.log(
      '[GET REVIEW BY CLASSES] -> iniciando busca por avaliações da turma id:${classSelected?.id}, nome: ${classSelected?.name}',
    );
    loading.value = true;
    final result = await _getReviewsByClassesUsecase(classSelected!.id);

    result.fold(
      (fail) {
        AppLogger.log(
          '[GET REVIEW BY CLASSES] -> erro ao obter as classes $fail',
        );
      },
      (reviewss) {
        AppLogger.log('[GET REVIEW BY CLASSES] -> sucesso ao obter classes!');
        _reviews.value = reviewss;
      },
    );
    loading.value = false;
  }

  List<SchoolDTO> get schools => _schools.value;
  List<ClassDTO> get classes => _classes.value;
  List<StudentDTO> get students => _students.value;
  List<ReviewDTO> get reviews => _reviews.value;

  static SchoolController get to => Get.find();
}
