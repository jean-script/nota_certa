import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_nota_certa/app/components/loading_widget.dart';
import 'package:ml_nota_certa/app/components/my_scaffold.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/student_controller.dart';

class StudentScansPage extends GetView<StudentController> {
  const StudentScansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Scans do aluno',
      child: controller.obx(
        (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---------------------------
              /// HEADER
              /// ---------------------------
              HeaderStudent(
                name: controller.student.name,
                registration: controller.student.registration,
                scansLength: controller.scans.length,
              ),
              const SizedBox(height: 24),

              const Text(
                'Histórico de scans',

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              /// ---------------------------
              /// LIST
              /// ---------------------------
              Expanded(
                child: ListView.separated(
                  itemCount: controller.scans.length,

                  separatorBuilder: (_, __) => const SizedBox(height: 16),

                  itemBuilder: (_, index) {
                    final scan = controller.scans[index];

                    return Container(
                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),

                        border: Border.all(color: Colors.grey.shade200),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          /// HEADER
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),

                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,

                                  shape: BoxShape.circle,
                                ),

                                child: Icon(
                                  Icons.document_scanner,

                                  color: Colors.green.shade700,
                                ),
                              ),

                              const SizedBox(width: 14),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      'Scan ${index + 1}',

                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      scan.createdAt.toString(),

                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              if (scan.grade != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),

                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,

                                    borderRadius: BorderRadius.circular(999),
                                  ),

                                  child: Text(
                                    '${scan.grade}',

                                    style: TextStyle(
                                      color: Colors.blue.shade700,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          /// IMAGE
                          if (scan.imagePath != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18),

                              child: Image.file(
                                File(scan.imagePath!),

                                height: 180,

                                width: double.infinity,

                                fit: BoxFit.cover,
                              ),
                            ),

                          const SizedBox(height: 20),

                          /// ANSWERS
                          const Text(
                            'Respostas detectadas',

                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 12),

                          Wrap(
                            spacing: 10,
                            runSpacing: 10,

                            children: List.generate(
                              scan.detectedAnswers?.length ?? 0,
                              (answerIndex) {
                                final answer =
                                    scan.detectedAnswers![answerIndex];

                                return Container(
                                  width: 58,

                                  padding: const EdgeInsets.all(10),

                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,

                                    borderRadius: BorderRadius.circular(16),

                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
                                  ),

                                  child: Column(
                                    children: [
                                      Text(
                                        'Q${answerIndex + 1}',

                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 6),

                                      Text(
                                        answer == null
                                            ? '-'
                                            : answer.toString(),

                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },

        /// ---------------------------
        /// LOADING
        /// ---------------------------
        onLoading: const LoadingWidget(),

        /// ---------------------------
        /// EMPTY
        /// ---------------------------
        onEmpty: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            HeaderStudent(
              name: controller.student.name,
              registration: controller.student.registration,
              scansLength: controller.scans.length,
            ),

            const SizedBox(height: 24),

            const Text(
              'Histórico de scans',

              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Icon(
                      Icons.document_scanner_outlined,
                      size: 72,
                      color: Colors.grey.shade400,
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Nenhum scan encontrado',

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Os scans aparecerão aqui',

                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        onError: (error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Icon(Icons.error_outline, size: 72, color: Colors.red.shade300),

                const SizedBox(height: 16),

                const Text(
                  'Erro ao carregar scans',

                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Text(
                  error ?? 'Erro desconhecido',

                  style: TextStyle(color: Colors.grey.shade600),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: controller.getScansStudent,

                  icon: const Icon(Icons.refresh),

                  label: const Text('Tentar novamente'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HeaderStudent extends StatelessWidget {
  const HeaderStudent({
    super.key,
    required this.name,
    required this.registration,
    required this.scansLength,
  });

  final String name;
  final String registration;
  final int scansLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            child: Text(
              name[0],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  registration,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '$scansLength scans',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
