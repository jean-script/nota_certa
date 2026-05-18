import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/reviews_dto.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/get_reviews_by_classes_usecase.dart';

abstract class IGetReviewsByClassesUsecase {
  Future<Either<Exception, List<ReviewDTO>>> call(String classId);
}

class GetReviewsByClassesUsecase extends IGetReviewsByClassesUsecase {
  final IGetReviewsByClassesRepository _repository;

  GetReviewsByClassesUsecase(this._repository);
  @override
  Future<Either<Exception, List<ReviewDTO>>> call(classId) {
    return _repository(classId);
  }
}
