import '../entities/education_entity.dart';
import '../repositories/portfolio_repository.dart';

/// Use case for retrieving education entries.
class GetEducationUseCase {
  final PortfolioRepository _repository;

  GetEducationUseCase(this._repository);

  Future<List<EducationEntity>> call() async {
    return await _repository.getEducation();
  }
}
