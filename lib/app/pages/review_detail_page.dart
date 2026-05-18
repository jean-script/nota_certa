import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ml_nota_certa/app/components/my_circle_avatar.dart';
import 'package:ml_nota_certa/app/components/my_scaffold.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/school_controller.dart';
import 'package:ml_nota_certa/app/routes/routes.dart';

class ReviewDetailPage extends GetResponsiveView {
  ReviewDetailPage({super.key})
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
    final controller = SchoolController.to;
    final review = controller.reviewSelected;

    if (review == null) {
      return const Scaffold(
        body: Center(child: Text('Nenhuma avaliação selecionada')),
      );
    }

    return MyScaffold(
      title: 'Detalhes da avaliação',
      child: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.title,
                        style: TextStyle(
                          fontSize: isTablet ? 32 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.blue.shade700,
                              size: isTablet ? 32 : null,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Application Date',
                                style: TextStyle(
                                  fontSize: isTablet ? 18 : 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                DateFormat(
                                  'dd/MM/yyyy',
                                ).format(review.applicationDate),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: isTablet ? 18 : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              Icons.quiz_outlined,
                              color: Colors.orange.shade700,
                              size: isTablet ? 32 : null,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Questions',
                                style: TextStyle(
                                  fontSize: isTablet ? 18 : 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                '${review.totalQuestions} questions',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: isTablet ? 18 : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Ações rápidas',
                style: TextStyle(
                  fontSize: isTablet ? 24 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _ActionCard(
                      title: 'Dashboard',
                      icon: Icons.bar_chart_rounded,
                      isTablet: isTablet,
                      onTap: () {
                        Get.toNamed(MyRoutes.DASHBOARD);
                      },
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _ActionCard(
                      title: 'Inserir respostas',
                      isTablet: isTablet,
                      icon: Icons.fact_check_outlined,
                      onTap: () {
                        Get.toNamed(MyRoutes.REGISTER_RESPONSE);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                'Gabarito',
                style: TextStyle(
                  fontSize: isTablet ? 24 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  itemCount: review.answerKey.length,
                  padding: EdgeInsets.only(bottom: 30.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio:
                        MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 1.5
                        : isTablet
                        ? 2.9
                        : 0.8,
                  ),
                  itemBuilder: (_, index) {
                    final answer = review.answerKey[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Q${index + 1}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 14),
                          MyCircleAvatar(text: answer.toString()),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isTablet,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  size: isTablet ? 32 : 28,
                  color: Colors.blue.shade700,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: isTablet ? 20 : 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
