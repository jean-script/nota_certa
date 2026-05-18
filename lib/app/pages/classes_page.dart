import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_nota_certa/app/components/loading_widget.dart';
import 'package:ml_nota_certa/app/components/my_scaffold.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/school_controller.dart';
import 'package:ml_nota_certa/app/components/empty_list_widget.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/widgets/list_item_widget.dart';
import 'package:ml_nota_certa/app/routes/routes.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  final RxBool loading = true.obs;
  final controller = SchoolController.to;

  @override
  void initState() {
    controller.getClassesBySchool(loading);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Turmas',
      child: Column(
        children: [
          ObxValue(
            (loading) => Expanded(
              child: loading.value
                  ? LoadingWidget()
                  : controller.classes.isEmpty
                  ? EmptyStateWidget(
                      title: 'Nenhuma turma encontrada',
                      message:
                          'Parece que esta escola ainda não tem nenhuma turma matriculada.',
                    )
                  : ListView.separated(
                      itemCount: controller.classes.length,
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        var clas = controller.classes[index];
                        return ListItemWidget(
                          title: clas.name,
                          onTap: () {
                            controller.classSelected = clas;
                            Get.toNamed(MyRoutes.REVIEW);
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
