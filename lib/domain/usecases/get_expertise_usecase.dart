import '../entities/expertise_entity.dart';
import '../repositories/portfolio_repository.dart';

/// Use case for retrieving technical expertise.
class GetExpertiseUseCase {
  final PortfolioRepository _repository;

  GetExpertiseUseCase(this._repository);

  Future<List<ExpertiseEntity>> call() async {
    return await _repository.getExpertise();
  }
}
