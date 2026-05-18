import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_nota_certa/app/components/empty_list_widget.dart';
import 'package:ml_nota_certa/app/components/loading_widget.dart';
import 'package:ml_nota_certa/app/components/my_scaffold.dart';
import 'package:ml_nota_certa/app/components/search_bar_widget.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/school_dto.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/school_controller.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/widgets/list_item_widget.dart';
import 'package:ml_nota_certa/app/routes/routes.dart';

class HomePage extends GetView<SchoolController> {
  HomePage({super.key});

  final RxString search = ''.obs;

  List<SchoolDTO> get filteredSchools {
    if (search.value.isEmpty) {
      return controller.schools;
    }

    return controller.schools.where((school) {
      return school.name.toLowerCase().contains(search.value.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Selecione a Unidade',
      child: controller.obx(
        (state) {
          return Column(
            children: [
              SearchBarWidget(
                controller: controller.searchController,
                hintText: 'Pesquisar escola',
                onChanged: (value) {
                  search.value = value;
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  final schools = filteredSchools;

                  if (schools.isEmpty) {
                    return EmptyStateWidget(
                      title: 'Nenhuma escola encontrada',
                      message: 'Nenhuma escola corresponde à pesquisa.',
                    );
                  }

                  return ListView.separated(
                    itemCount: schools.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (_, index) {
                      final school = schools[index];
                      return ListItemWidget(
                        title: school.name,
                        subtitle: 'Toque para visualizar as turmas',
                        onTap: () {
                          controller.schoolSelected = school;
                          Get.toNamed(MyRoutes.CLASSES);
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          );
        },
        onLoading: const LoadingWidget(),
        onEmpty: EmptyStateWidget(
          title: 'Nenhuma escola encontrada',
          message: 'Não foi possível carregar as escolas.',
        ),
        onError: (error) {
          return EmptyStateWidget(
            title: 'Erro ao carregar escolas',
            message: error ?? 'Ocorreu um erro inesperado.',
          );
        },
      ),
    );
  }
}
