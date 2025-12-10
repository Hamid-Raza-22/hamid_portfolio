import '../entities/stat_entity.dart';
import '../repositories/portfolio_repository.dart';

/// Use case for retrieving stats/achievements.
class GetStatsUseCase {
  final PortfolioRepository _repository;

  GetStatsUseCase(this._repository);

  Future<List<StatEntity>> call() async {
    return await _repository.getStats();
  }
}
