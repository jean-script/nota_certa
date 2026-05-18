import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_nota_certa/app/modules/dashboard/presenter/controllers/dashboard_controller.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/school_controller.dart';

class ProgressCard extends GetView<DashboardController> {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(Icons.fact_check_outlined, color: Colors.blue.shade700),

              const SizedBox(width: 10),

              const Text(
                'Progresso da correção',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Text(
            '${controller.completedStudents.value} de '
            '${SchoolController.to.students.length} alunos corrigidos',
          ),

          const SizedBox(height: 14),

          ClipRRect(
            borderRadius: BorderRadius.circular(99),

            child: LinearProgressIndicator(
              value: controller.correctionProgress,
              minHeight: 14,
            ),
          ),
        ],
      ),
    );
  }
}
