import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:ml_nota_certa/app/modules/dashboard/presenter/controllers/dashboard_controller.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/school_controller.dart';

class PdfService {
  Future<void> generate(DashboardController controller) async {
    final pdf = pw.Document();

    final review = SchoolController.to.reviewSelected!;

    /// =========================================================
    /// PAGE 2 -> ANSWER KEY
    /// =========================================================
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,

        build: (context) {
          return [];
        },
      ),
    );

    /// =========================================================
    /// PAGE 3+ -> STUDENTS ANSWERS
    /// =========================================================
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,

        build: (context) {
          final headers = [
            'Aluno',

            ...List.generate(
              review.answerKey.length,
              (index) => 'Q${index + 1}',
            ),

            'Nota',
          ];

          final data = controller.ranking.map((student) {
            final row = <String>[student.studentName];

            for (int i = 0; i < review.answerKey.length; i++) {
              final answer = student.answers[i];

              if (answer == null) {
                row.add('-');
                continue;
              }

              final correct = answer == review.answerKey[i];

              row.add(correct ? '$answer' : '$answer');
            }

            row.add(student.grade.toStringAsFixed(1));

            return row;
          }).toList();

          return [
            pw.Text(
              'Respostas dos alunos',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),

            pw.SizedBox(height: 24),

            pw.Table.fromTextArray(
              headers: headers,

              data: data,

              border: pw.TableBorder.all(),

              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),

              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.grey300,
              ),

              cellAlignment: pw.Alignment.center,

              cellStyle: const pw.TextStyle(fontSize: 9),

              columnWidths: {0: const pw.FixedColumnWidth(120)},
            ),

            pw.SizedBox(height: 24),

            pw.Text(
              'Gabarito',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),

            pw.SizedBox(height: 24),

            pw.Table.fromTextArray(
              border: pw.TableBorder.all(),

              headers: ['Questão', 'Resposta correta'],

              data: List.generate(review.answerKey.length, (index) {
                return ['Q${index + 1}', review.answerKey[index].toString()];
              }),
            ),
          ];
        },
      ),
    );

    /// =========================================================
    /// PAGE 1 -> DASHBOARD
    /// =========================================================
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,

        build: (context) {
          return [
            pw.Text(
              'Dashboard da Avaliação',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),

            pw.SizedBox(height: 8),

            pw.Text(review.title, style: const pw.TextStyle(fontSize: 16)),

            pw.SizedBox(height: 24),

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                _metricCard(
                  title: 'Média',
                  value: controller.averageGrade.value.toStringAsFixed(1),
                ),

                _metricCard(
                  title: 'Maior nota',
                  value: controller.highestGrade.value.toStringAsFixed(1),
                ),
              ],
            ),

            pw.SizedBox(height: 16),

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                _metricCard(
                  title: 'Concluídos',
                  value: controller.completedStudents.value.toString(),
                ),

                _metricCard(
                  title: 'Pendentes',
                  value: controller.pendingStudents.value.toString(),
                ),
              ],
            ),

            pw.SizedBox(height: 32),

            pw.Text(
              'Questões com maior índice de erro',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),

            pw.SizedBox(height: 16),

            ...controller.mostWrongQuestions.map((question) {
              return pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 12),

                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,

                  children: [
                    pw.Text('Q${question.question}'),

                    pw.Text(
                      '${question.errorPercent.toStringAsFixed(0)}%',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
              );
            }),
          ];
        },
      ),
    );

    /// =========================================================
    /// OPEN PDF
    /// =========================================================
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  pw.Widget _metricCard({required String title, required String value}) {
    return pw.Container(
      width: 220,
      padding: const pw.EdgeInsets.all(16),

      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),

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
