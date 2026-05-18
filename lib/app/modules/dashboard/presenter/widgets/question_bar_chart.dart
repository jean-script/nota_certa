import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_nota_certa/app/modules/dashboard/presenter/controllers/dashboard_controller.dart';

class QuestionBarChartWidget extends GetView<DashboardController> {
  const QuestionBarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final questions = controller.mostWrongQuestions;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Erros por questão',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 260,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,

                maxY: 100,

                borderData: FlBorderData(show: false),

                gridData: FlGridData(drawVerticalLine: false),

                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      reservedSize: 32,
                    ),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,

                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();

                        if (index >= questions.length) {
                          return const SizedBox();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            'Q${questions[index].question}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                barGroups: List.generate(questions.length, (index) {
                  final question = questions[index];
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: question.errorPercent,
                        width: 20,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
