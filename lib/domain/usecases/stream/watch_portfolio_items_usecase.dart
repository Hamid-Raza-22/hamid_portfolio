import '../../entities/entities.dart';
import '../../repositories/portfolio_repository_stream.dart';

/// Use case for watching portfolio items in real-time.
class WatchPortfolioItemsUseCase {
  final PortfolioRepositoryStream _repository;

  WatchPortfolioItemsUseCase(this._repository);

  Stream<List<PortfolioEntity>> call() => _repository.watchPortfolioItems();
}
