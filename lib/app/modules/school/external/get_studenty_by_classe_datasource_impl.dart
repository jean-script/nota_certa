import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/studenty_dto.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/get_studenty_by_classe_datasource.dart';

class GetStudentyByClasseDatasourceImpl extends IGetStudentyByClasseDatasource {
  @override
  Future<List<StudentDTO>> call(String classId) async {
    try {
      final data = await rootBundle.loadString('assets/mocks/alunos.json');

      if (data.isEmpty) {
        throw Exception(
          'Não foi possível encontrar estudantes para esta turma',
        );
      }

      return (json.decode(data) as List)
          .map((s) => StudentDTO.fromJson(s))
          .toList()
          .where((s) => s.classroomId == classId)
          .toList();
    } catch (e) {
      throw Exception('Não foi possível encontrar estudantes para esta turma');
    }
  }
}
