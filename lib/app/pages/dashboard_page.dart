import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_nota_certa/app/components/loading_widget.dart';
import 'package:ml_nota_certa/app/components/my_scaffold.dart';
import 'package:ml_nota_certa/app/modules/dashboard/presenter/controllers/dashboard_controller.dart';
import 'package:ml_nota_certa/app/modules/dashboard/presenter/widgets/dashboard_card.dart';
import 'package:ml_nota_certa/app/modules/dashboard/presenter/widgets/question_bar_chart.dart';
import 'package:ml_nota_certa/app/modules/dashboard/presenter/widgets/ranking_medal_widget.dart';

class DashboardPage extends GetResponsiveView<DashboardController> {
  DashboardPage({super.key})
    : super(alwaysUseBuilder: false, settings: ResponsiveScreenSettings());
  @override
  Widget phone() => _buildContent(Get.context!, isMobile: true);

  @override
  Widget tablet() => _buildContent(Get.context!, isTablet: true);

  @override
  Widget desktop() => _buildContent(Get.context!, isTablet: true);

  Widget _buildContent(
    BuildContext context, {
    bool isMobile = false,
    bool isTablet = false,
  }) {
    return MyScaffold(
      title: 'Dashboard',
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 9.0),
          child: IconButton(
            onPressed: controller.exportPdf,
            icon: const Icon(Icons.picture_as_pdf),
          ),
        ),
      ],
      child: controller.obx((state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ProgressCard(),
              // const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isTablet
                    ? 4.0
                    : MediaQuery.of(context).orientation ==
                          Orientation.landscape
                    ? 2.2
                    : 1.4,
                children: [
                  DashboardCard(
                    title: 'Média',
                    value: controller.averageGrade.value.toStringAsFixed(1),
                    icon: Icons.analytics_outlined,
                    isTablet: isTablet,
                    iconColor: Colors.lightBlue,
                  ),
                  DashboardCard(
                    title: 'Maior nota',
                    value: controller.highestGrade.value.toStringAsFixed(1),
                    icon: Icons.emoji_events_outlined,
                    isTablet: isTablet,
                    iconColor: Colors.amberAccent,
                  ),
                  DashboardCard(
                    title: 'Concluídos',
                    value: controller.completedStudents.value.toString(),
                    icon: Icons.check_circle_outline,
                    isTablet: isTablet,
                    iconColor: Colors.lightGreen,
                  ),
                  DashboardCard(
                    title: 'Pendentes',
                    value: controller.pendingStudents.value.toString(),
                    icon: Icons.pending_actions_outlined,
                    isTablet: isTablet,
                    iconColor: Colors.redAccent.shade100,
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const QuestionBarChartWidget(),
              const SizedBox(height: 16),

              if (controller.mostWrongQuestions.any((q) => q.errorPercent != 0))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Questões com mais erro',
                      style: TextStyle(
                        fontSize: isTablet ? 26 : 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: controller.mostWrongQuestions.take(4).map((
                          question,
                        ) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.red.shade50,
                                  child: Text(
                                    'Q${question.question}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${question.errorPercent.toStringAsFixed(0)}% erraram',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(99),
                                        child: LinearProgressIndicator(
                                          value: question.errorPercent / 100,
                                          minHeight: 10,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),

              Text(
                'Classificação dos alunos',
                style: TextStyle(
                  fontSize: isTablet ? 26 : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.ranking.length,
                  separatorBuilder: (_, __) =>
                      Divider(height: 1, color: Colors.grey.shade200),
                  itemBuilder: (_, index) {
                    final student = controller.ranking[index];

                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),

                      child: Row(
                        children: [
                          RankingMedalWidget(index: index),
                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  student.studentName,
                                  style: TextStyle(
                                    fontSize: isTablet ? 22 : 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  'Aluno',
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(14),
                            ),

                            child: Text(
                              student.grade.toStringAsFixed(1),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isTablet ? 20 : 16,
                                color: Colors.blue.shade700,
                              ),
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
      }, onLoading: const LoadingWidget()),
    );
  }
}
