import '../entities/achievement_entity.dart';
import '../repositories/portfolio_repository.dart';

/// Use case for retrieving achievements.
class GetAchievementsUseCase {
  final PortfolioRepository _repository;

  GetAchievementsUseCase(this._repository);

  Future<List<AchievementEntity>> call() async {
    return await _repository.getAchievements();
  }
}
