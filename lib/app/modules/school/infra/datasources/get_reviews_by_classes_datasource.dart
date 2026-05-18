import 'package:ml_nota_certa/app/modules/school/domain/entities/reviews_dto.dart';

abstract class IGetReviewsByClassesDatasource {
  Future<List<ReviewDTO>> call(String classId);
}
