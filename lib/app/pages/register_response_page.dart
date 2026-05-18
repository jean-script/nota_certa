import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_nota_certa/app/components/loading_widget.dart';
import 'package:ml_nota_certa/app/components/my_circle_avatar.dart';
import 'package:ml_nota_certa/app/components/my_scaffold.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/studenty_dto.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/evaluation_controller.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/school_controller.dart';

class RegisterResponseStudentPage extends GetView<EvaluationController> {
  const RegisterResponseStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Respostas dos alunos',
      floatingActionButton: SizedBox(
        width: 220,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            controller.saveAnswers();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade50,
            foregroundColor: Colors.blue.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          // icon: const Icon(Icons.save_outlined),
          child: const Text('Salvar respostas'),
        ),
      ),
      child: controller.obx(
        (students) {
          final review = SchoolController.to.reviewSelected;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review!.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Preencha as respostas dos alunos.',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.document_scanner_outlined),
                          label: const Text('Cartão resposta'),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.blue.shade50,
                            foregroundColor: Colors.blue.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Respostas dos alunos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: students?.length ?? 0,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (_, studentIndex) {
                    final student = students![studentIndex];

                    return GetBuilder<EvaluationController>(
                      id: 'student_${student.id}',
                      builder: (_) {
                        return StudentAnswersCard(
                          student: student,
                          totalQuestions: controller.totalQuestions,
                          answers: controller.answers[student.id]!,
                          onChanged: (questionIndex, value) {
                            controller.updateAnswer(
                              studentId: student.id,
                              questionIndex: questionIndex,
                              value: value,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
        onLoading: const LoadingWidget(),
        onEmpty: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people_outline, size: 72, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              const Text(
                'Nenhum aluno encontrado',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                'Os alunos aparecerão aqui',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentAnswersCard extends StatefulWidget {
  const StudentAnswersCard({
    super.key,
    required this.student,
    required this.totalQuestions,
    required this.answers,
    required this.onChanged,
  });

  final StudentDTO student;

  final int totalQuestions;

  final List<int?> answers;

  final void Function(int questionIndex, int? value) onChanged;

  @override
  State<StudentAnswersCard> createState() => _StudentAnswersCardState();
}

class _StudentAnswersCardState extends State<StudentAnswersCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final totalAnswered = widget.answers.where((e) => e != null).length;
    final completed = totalAnswered == widget.totalQuestions;

    return Container(
      // duration: const Duration(milliseconds: 420),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: expanded ? Colors.blue.shade100 : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: false,
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          childrenPadding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onExpansionChanged: (value) {
            setState(() {
              expanded = value;
            });
          },
          leading: Stack(
            children: [
              MyCircleAvatar(text: widget.student.name[0]),

              if (completed)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          title: Text(
            widget.student.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              widget.student.registration,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          trailing: Icon(
            expanded
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          //   decoration: BoxDecoration(
          //     color: completed ? Colors.green.shade50 : Colors.orange.shade50,
          //     borderRadius: BorderRadius.circular(999),
          //   ),
          //   child: Text(
          //     '$totalAnswered/${widget.totalQuestions}',
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       color: completed
          //           ? Colors.green.shade700
          //           : Colors.orange.shade700,
          //     ),
          //   ),
          // ),
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,

              children: List.generate(widget.totalQuestions, (questionIndex) {
                final selectedValue = widget.answers[questionIndex];

                return Container(
                  width: 110,

                  padding: const EdgeInsets.all(12),

                  decoration: BoxDecoration(
                    color: selectedValue != null
                        ? Colors.green.shade50
                        : Colors.grey.shade50,

                    borderRadius: BorderRadius.circular(18),

                    border: Border.all(
                      color: selectedValue != null
                          ? Colors.green.shade100
                          : Colors.grey.shade200,
                    ),
                  ),

                  child: Column(
                    children: [
                      Text(
                        'Q${questionIndex + 1}',

                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 10),

                      PopupMenuButton<int>(
                        onSelected: (value) {
                          widget.onChanged(questionIndex, value);
                        },

                        itemBuilder: (_) {
                          return List.generate(5, (index) {
                            return PopupMenuItem<int>(
                              value: index + 1,

                              child: Text((index + 1).toString()),
                            );
                          });
                        },

                        child: Container(
                          height: 46,

                          alignment: Alignment.center,

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(14),

                            border: Border.all(
                              color: selectedValue != null
                                  ? Colors.green
                                  : Colors.grey.shade300,
                            ),
                          ),

                          child: Text(
                            selectedValue?.toString() ?? '-',

                            style: TextStyle(
                              fontSize: 16,

                              fontWeight: FontWeight.bold,

                              color: selectedValue != null
                                  ? Colors.green.shade700
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
