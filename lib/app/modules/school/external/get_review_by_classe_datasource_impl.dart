import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/reviews_dto.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/get_reviews_by_classes_datasource.dart';

class GetReviewByClasseDatasourceImpl extends IGetReviewsByClassesDatasource {
  @override
  Future<List<ReviewDTO>> call(String classId) async {
    try {
      final data = await rootBundle.loadString('assets/mocks/avaliacoes.json');

      if (data.isEmpty) {
        throw Exception('Não foi possível encontrar turmas para esta escola');
      }

      // await Future.delayed(Duration(seconds: 2));

      return (json.decode(data) as List)
          .map((clas) => ReviewDTO.fromJson(clas))
          .toList()
          .where((review) => review.classroomId == classId)
          .toList();
    } catch (e) {
      print('error $e');
      throw Exception('Não foi possível encontrar turmas para esta escola');
    }
  }
}
