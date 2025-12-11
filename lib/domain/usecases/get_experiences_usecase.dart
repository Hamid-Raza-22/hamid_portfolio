import '../entities/experience_entity.dart';
import '../repositories/portfolio_repository.dart';

/// Use case for retrieving work experiences.
class GetExperiencesUseCase {
  final PortfolioRepository _repository;

  GetExperiencesUseCase(this._repository);

  Future<List<ExperienceEntity>> call() async {
    return await _repository.getExperiences();
  }
}
