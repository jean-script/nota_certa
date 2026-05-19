import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_nota_certa/app/modules/camera/presenter/controllers/camera_controller.dart';
import 'package:ml_nota_certa/app/pages/scan_preview_page.dart';
import 'package:ml_nota_certa/app/utils/app_logger.dart';

class TakeAnswerSheetPicturePage extends StatefulWidget {
  const TakeAnswerSheetPicturePage({super.key});

  @override
  State<TakeAnswerSheetPicturePage> createState() =>
      _TakeAnswerSheetPicturePageState();
}

class _TakeAnswerSheetPicturePageState
    extends State<TakeAnswerSheetPicturePage> {
  final controller = MyCameraController.to;

  CameraController? cameraController;

  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();

    initCamera();
  }

  Future<void> initCamera() async {
    try {
      final cameras = await availableCameras();

      final backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );

      cameraController = CameraController(
        backCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await cameraController!.initialize();

      if (!mounted) return;

      setState(() {
        isCameraInitialized = true;
      });

      AppLogger.log('[CAMERA] -> camera inicializada');
    } catch (e) {
      AppLogger.log('[CAMERA] -> erro ao iniciar camera $e');
    }
  }

  @override
  void dispose() {
    AppLogger.log('[CAMERA] -> dispose camera');

    cameraController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: !isCameraInitialized || cameraController == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  /// CAMERA
                  Positioned.fill(child: CameraPreview(cameraController!)),
      
                  /// OVERLAY
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * .74,
                          height: MediaQuery.of(context).size.height * .48,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.greenAccent,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
      
                  /// TEXTO
                  Positioned(
                    top: 60,
                    left: 24,
                    right: 24,
                    child: Column(
                      children: const [
                        Text(
                          'Encaixe o cartão resposta',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
      
                        SizedBox(height: 8),
      
                        Text(
                          'Posicione o cartão dentro da área verde',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
      
                  /// BOTÃO FOTO
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Obx(() {
                        return GestureDetector(
                          onTap: controller.isTakingPicture.value
                              ? null
                              : () async {
                                  await controller.takeAnswerSheetPicture(
                                    cameraController!,
                                  );
      
                                  final image = controller.answerSheetImage.value;
      
                                  if (image == null) {
                                    return;
                                  }
      
                                  Get.off(() => const ScanAnswerSheetPage());
                                },
      
                          child: Container(
                            width: 82,
                            height: 82,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 5),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
