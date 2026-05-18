import 'package:fpdart/fpdart.dart';
import 'package:ml_nota_certa/app/modules/school/domain/entities/reviews_dto.dart';
import 'package:ml_nota_certa/app/modules/school/domain/repositories/get_reviews_by_classes_usecase.dart';
import 'package:ml_nota_certa/app/modules/school/infra/datasources/get_reviews_by_classes_datasource.dart';

class GetReviewByClassesRepositoryImpl extends IGetReviewsByClassesRepository {
  final IGetReviewsByClassesDatasource _datasource;

  GetReviewByClassesRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, List<ReviewDTO>>> call(String classId) async {
    try {
      return Right(await _datasource(classId));
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
