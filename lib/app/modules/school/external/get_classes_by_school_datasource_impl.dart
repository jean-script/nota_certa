import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/classes_dto.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/get_classes_by_school_datasource.dart';

class GetClassesBySchoolDatasourceImpl extends IGetClassesBySchoolDatasource {
  @override
  Future<List<ClassDTO>> call(String schoolId) async {
    try {
      final data = await rootBundle.loadString('assets/mocks/turmas.json');

      if (data.isEmpty) {
        throw Exception('Não foi possível encontrar turmas para esta escola');
      }

      // await Future.delayed(Duration(seconds: 2));

      return (json.decode(data) as List)
          .map((clas) => ClassDTO.fromJson(clas))
          .toList()
          .where((clas) => clas.schoolId == schoolId)
          .toList();
    } catch (e) {
      print('error $e');
      throw Exception('Não foi possível encontrar turmas para esta escola');
    }
  }
}
