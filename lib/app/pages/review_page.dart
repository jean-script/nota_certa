import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_nota_certa/app/components/loading_widget.dart';
import 'package:ml_nota_certa/app/components/my_scaffold.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/school_controller.dart';
import 'package:ml_nota_certa/app/components/empty_list_widget.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/widgets/list_item_widget.dart';
import 'package:ml_nota_certa/app/routes/routes.dart';
import 'package:ml_nota_certa/app/utils/format_date.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final RxBool loading = true.obs;
  @override
  void initState() {
    SchoolController.to.getReviewsByClassesUsecase(loading);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Avaliações',
      child: Column(
        children: [
          ObxValue(
            (loading) => Expanded(
              child: loading.value
                  ? LoadingWidget()
                  : SchoolController.to.reviews.isEmpty
                  ? EmptyStateWidget(
                      title: 'Nenhuma Avaliação encontrada',
                      message:
                          'Parece que esta turma ainda não tem nenhuma avaliação registrada.',
                    )
                  : ListView.separated(
                      itemCount: SchoolController.to.reviews.length,
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        var review = SchoolController.to.reviews[index];
                        return ListItemWidget(
                          title: review.title,
                          data: formatDate(review.applicationDate),
                          onTap: () {
                            SchoolController.to.reviewSelected = review;
                            Get.toNamed(MyRoutes.REVIEW_DETAIL);
                          },
                        );
                      },
                    ),
            ),
            loading,
          ),
        ],
      ),
    );
  }
}
