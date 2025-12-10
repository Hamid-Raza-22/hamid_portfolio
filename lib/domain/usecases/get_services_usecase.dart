import '../entities/service_entity.dart';
import '../repositories/portfolio_repository.dart';

/// Use case for retrieving services.
/// Follows Single Responsibility Principle.
class GetServicesUseCase {
  final PortfolioRepository _repository;

  GetServicesUseCase(this._repository);

  Future<List<ServiceEntity>> call() async {
    return await _repository.getServices();
  }
}
