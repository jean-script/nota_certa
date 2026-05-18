import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/school_dto.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/get_school_datasource.dart';

class GetSchoolDatasourceImpl extends IGetSchoolDatasource {
  @override
  Future<List<SchoolDTO>> call() async {
    try {
      final data = await rootBundle.loadString('assets/mocks/escola.json');

      if (data.isEmpty) {
        throw Exception('Não foi possível encontrar escolas no momento');
      }

      return (json.decode(data) as List)
          .map((school) => SchoolDTO.fromJson(school))
          .toList();
    } catch (e) {
      throw Exception('Não foi possível encontrar escolas no momento');
    }
  }
}
