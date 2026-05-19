import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/entities/scan_dto.dart';
import 'package:ml_nota_certa/app/modules/camera/domain/usecase/save_scan_usecase.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/evaluation_controller.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/school_controller.dart';
import 'package:ml_nota_certa/app/services/omr_service.dart';
import 'package:ml_nota_certa/app/utils/app_logger.dart';

class MyCameraController extends GetxController {
  final ISaveScanUsecase _saveScanUsecase;

  MyCameraController(this._saveScanUsecase);

  final omr = OMRService();

  /// ---------------------------
  /// CAMERA
  /// ---------------------------

  final RxBool isTakingPicture = false.obs;

  /// ---------------------------
  /// IMAGE
  /// ---------------------------

  Rx<File?> answerSheetImage = Rx<File?>(null);

  /// ---------------------------
  /// STUDENT
  /// ---------------------------

  final RxnString selectedStudentId = RxnString();

  @override
  void onInit() {
    super.onInit();

    final students = SchoolController.to.students;

    if (students.isNotEmpty) {
      selectedStudentId.value = students.first.id;
    }
  }

  /// ---------------------------
  /// TAKE PHOTO
  /// ---------------------------

  Future<void> takeAnswerSheetPicture(CameraController cameraController) async {
    try {
      if (!cameraController.value.isInitialized) {
        return;
      }

      if (isTakingPicture.value) {
        return;
      }

      isTakingPicture.value = true;

      AppLogger.log('[TAKE IMAGE] -> tirando foto');

      final file = await cameraController.takePicture();

      final imageFile = File(file.path);

      answerSheetImage.value = imageFile;

      AppLogger.log('[TAKE IMAGE] -> imagem obtida ${imageFile.path}');
    } catch (e) {
      AppLogger.log('[TAKE IMAGE] -> erro ao tirar foto $e');
    } finally {
      isTakingPicture.value = false;
    }
  }

  /// ---------------------------
  /// SAVE SCAN
  /// ---------------------------

  Future<void> saveScan() async {
    final studentId = selectedStudentId.value;

    final image = answerSheetImage.value;

    if (studentId == null || image == null) {
      return;
    }

    final review = SchoolController.to.reviewSelected!;

    final answers = await omr.detectAnswers(image);

    AppLogger.log('[OMR] -> respostas detectadas $answers');

    // return;

    final result = await _saveScanUsecase(
      ScanDTO(
        id: 'scan_${review.id}_$studentId',
        studentId: studentId,
        evaluationId: review.id,
        imagePath: image.path,
        createdAt: DateTime.now(),
        detectedAnswers: answers,
        grade: EvaluationController.to.calculateStudentGrade(studentId),
      ),
    );

    await result.fold(
      (fail) {
        AppLogger.log('[SAVE SCAN] -> erro ao salvar scan ${fail.toString()}');
      },
      (_) async {
        AppLogger.log('[SAVE SCAN] -> sucesso ao salvar');
        Future.delayed(Duration(seconds: 1), () {
          Get.snackbar('Sucesso', 'Ao salvar imagem');
        });
      },
    );
  }

  /// ---------------------------
  /// CLEAR IMAGE
  /// ---------------------------

  void clearImage() {
    answerSheetImage.value = null;
  }

  /// ---------------------------
  /// DISPOSE
  /// ---------------------------

  static MyCameraController get to => Get.find();
}
