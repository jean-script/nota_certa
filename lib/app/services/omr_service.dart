import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image/image.dart' as img;
import 'package:ml_nota_certa/app/utils/app_logger.dart';
import 'package:opencv_dart/opencv_dart.dart' as cv;

class OMRService {
  Future<List<int?>> detectAnswers(File file) async {
    final mat = cv.imread(file.path);

    /// grayscale apenas
    final gray = cv.cvtColor(mat, cv.COLOR_BGR2GRAY);

    final debugPath = '${file.parent.path}/debug_gray.jpg';

    cv.imwrite(debugPath, gray);

    final bytes = File(debugPath).readAsBytesSync();

    final image = img.decodeImage(bytes);

    if (image == null) {
      return [];
    }

    final answers = <int?>[];

    for (int question = 0; question < 10; question++) {
      final values = <double>[];

      for (int option = 0; option < 5; option++) {
        final rect = _getBubbleRect(image, question, option);

        _drawRect(image, rect);

        final darkness = _calculateDarkness(image, rect);

        values.add(darkness);
      }

      AppLogger.log('[OMR] questão ${question + 1} -> $values');

      double darkest = -1;

      int selected = -1;

      for (int i = 0; i < values.length; i++) {
        if (values[i] > darkest) {
          darkest = values[i];
          selected = i;
        }
      }

      answers.add(selected + 1);
    }

    /// IMAGEM GERADA PARA TESTE...
    // final debugRects = '${file.parent.path}/debug_rects.jpg';

    // File(debugRects).writeAsBytesSync(img.encodeJpg(image));

    // AppLogger.log('[OMR] -> respostas detectadas $answers');

    // Get.to(
    //   () => Scaffold(
    //     appBar: AppBar(title: const Text('Debug OMR')),
    //     body: Image.file(File(debugRects)),
    //   ),
    // );

    return answers;
  }

  /// =========================================================
  /// DRAW RECT
  /// =========================================================

  void _drawRect(img.Image image, RectData rect) {
    img.drawRect(
      image,
      x1: rect.x,
      y1: rect.y,
      x2: rect.x + rect.width,
      y2: rect.y + rect.height,
      color: img.ColorRgb8(255, 0, 0),
      thickness: 3,
    );
  }

  /// =========================================================
  /// BUBBLE POSITION
  /// =========================================================

  RectData _getBubbleRect(img.Image image, int question, int option) {
    final width = image.width;
    final height = image.height;

    /// PRIMEIRA BOLINHA
    final startX = width * 0.32;

    final startY = height * 0.292;

    /// ESPAÇAMENTO HORIZONTAL
    final horizontalSpacing = width * 0.120;

    /// ESPAÇAMENTO VERTICAL
    final verticalSpacing = height * 0.047;

    /// TAMANHO DA ÁREA
    final bubbleSize = width * 0.040;

    final centerX = startX + (option * horizontalSpacing);

    final centerY = startY + (question * verticalSpacing);

    return RectData(
      x: (centerX - bubbleSize / 2).toInt(),
      y: (centerY - bubbleSize / 2).toInt(),
      width: bubbleSize.toInt(),
      height: bubbleSize.toInt(),
    );
  }

  /// =========================================================
  /// COUNT DARK PIXELS
  /// =========================================================

  double _calculateDarkness(img.Image image, RectData rect) {
    double totalDarkness = 0;

    int count = 0;

    for (int y = rect.y; y < rect.y + rect.height; y++) {
      for (int x = rect.x; x < rect.x + rect.width; x++) {
        final pixel = image.getPixel(x, y);

        final brightness = (pixel.r + pixel.g + pixel.b) / 3;

        /// quanto menor brilho,
        /// mais escuro
        totalDarkness += (255 - brightness);

        count++;
      }
    }

    return totalDarkness / count;
  }
}

class RectData {
  final int x;
  final int y;
  final int width;
  final int height;

  RectData({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });
}
