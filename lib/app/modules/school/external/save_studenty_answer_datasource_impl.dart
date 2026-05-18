import 'package:hive_flutter/adapters.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/student_evaluation_answer_hive.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/save_studenty_answer_datasource.dart';

class SaveStudentyAnswerDatasourceImpl extends ISaveStudentyAnswerDatasource {
  @override
  Future<void> call(StudentEvaluationAnswerHive dto) async {
    try {
      final Box<StudentEvaluationAnswerHive> box =
          Hive.box<StudentEvaluationAnswerHive>('student_answers');

      await box.put(dto.id, dto);
    } catch (e) {
      print('erro ao salvar $e');
      rethrow;
    }
  }
}
