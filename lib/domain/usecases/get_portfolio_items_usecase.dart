import '../entities/portfolio_entity.dart';
import '../repositories/portfolio_repository.dart';

/// Use case for retrieving portfolio items.
class GetPortfolioItemsUseCase {
  final PortfolioRepository _repository;

  GetPortfolioItemsUseCase(this._repository);

  Future<List<PortfolioEntity>> call() async {
    return await _repository.getPortfolioItems();
  }
}
