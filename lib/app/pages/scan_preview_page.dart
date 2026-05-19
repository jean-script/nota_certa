import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_nota_certa/app/components/my_scaffold.dart';
import 'package:ml_nota_certa/app/modules/camera/presenter/controllers/camera_controller.dart';
import 'package:ml_nota_certa/app/modules/camera/presenter/widgets/scan_preview_widget.dart';
import 'package:ml_nota_certa/app/modules/camera/presenter/widgets/select_studenty.dart';
import 'package:ml_nota_certa/app/pages/take_answer_sheet_picture_page.dart';
import 'package:ml_nota_certa/app/routes/routes.dart';

class ScanAnswerSheetPage extends GetView<MyCameraController> {
  const ScanAnswerSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Cartão resposta',
      floatingActionButton: SizedBox(
        width: 220,
        height: 56,
        child: ElevatedButton(
          onPressed: () async {
            await controller.saveScan();

            Get.back();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade50,
            foregroundColor: Colors.blue.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          // icon: const Icon(Icons.save_outlined),
          child: const Text('Salvar cartão'),
        ),
      ),
      child: Obx(() {
        final image = controller.answerSheetImage.value;

        if (image == null) {
          return Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Get.to(() => const TakeAnswerSheetPicturePage());
              },
              icon: const Icon(Icons.camera_alt_outlined),

              label: const Text('Tirar foto'),
            ),
          );
        }

        return Column(
          children: [
            /// SELECT STUDENT
            StudentSelector(),

            const SizedBox(height: 16),

            /// IMAGE
            Expanded(
              child: ScanPreviewWidget(
                file: image,

                onRetake: () {
                  Get.offNamed(MyRoutes.CAMERA_PAGE);
                },

                onRemove: () {
                  Get.back();
                  controller.answerSheetImage.value = null;
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
