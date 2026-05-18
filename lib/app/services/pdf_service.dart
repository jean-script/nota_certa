import 'package:ml_nota_certa/app/modules/dashboard/presenter/controllers/dashboard_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  Future<void> generate(DashboardController controller) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,

        build: (context) {
          return [
            pw.Text(
              'Dashboard da Avaliação',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),

            pw.SizedBox(height: 24),

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,

              children: [
                _card(
                  'Média',
                  controller.averageGrade.value.toStringAsFixed(1),
                ),

                _card(
                  'Maior nota',
                  controller.highestGrade.value.toStringAsFixed(1),
                ),
              ],
            ),

            pw.SizedBox(height: 32),

            pw.Text(
              'Ranking',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),

            pw.SizedBox(height: 12),

            ...controller.ranking.map((student) {
              return pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 8),

                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,

                  children: [
                    pw.Text(student.studentName),

                    pw.Text(student.grade.toStringAsFixed(1)),
                  ],
                ),
              );
            }),
            pw.SizedBox(height: 32),

            pw.Text(
              'Questões com mais erros',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),

            pw.SizedBox(height: 12),

            ...controller.mostWrongQuestions.map((question) {
              return pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Q${question.question}'),
                  pw.Text(question.errorPercent.toString()),
                ],
              );
            }),
          ];
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  pw.Widget _card(String title, String value) {
    return pw.Container(
      width: 200,
      padding: const pw.EdgeInsets.all(16),

      decoration: pw.BoxDecoration(
        border: pw.Border.all(),
        borderRadius: pw.BorderRadius.circular(12),
      ),

      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,

        children: [
          pw.Text(
            value,
            style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
          ),

          pw.SizedBox(height: 8),

          pw.Text(title),
        ],
      ),
    );
  }
}
