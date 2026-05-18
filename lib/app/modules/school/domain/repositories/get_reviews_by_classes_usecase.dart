import 'package:fpdart/fpdart.dart';

import 'package:ml_nota_certa/app/modules/school/domain/entities/reviews_dto.dart';

abstract class IGetReviewsByClassesRepository {
  Future<Either<Exception, List<ReviewDTO>>> call(String classId);
}
