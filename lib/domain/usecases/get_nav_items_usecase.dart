import '../entities/nav_item_entity.dart';
import '../repositories/portfolio_repository.dart';

/// Use case for retrieving navigation items.
class GetNavItemsUseCase {
  final PortfolioRepository _repository;

  GetNavItemsUseCase(this._repository);

  Future<List<NavItemEntity>> call() async {
    return await _repository.getNavItems();
  }
}
