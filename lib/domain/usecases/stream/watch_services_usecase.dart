import '../../entities/entities.dart';
import '../../repositories/portfolio_repository_stream.dart';

/// Use case for watching services in real-time.
class WatchServicesUseCase {
  final PortfolioRepositoryStream _repository;

  WatchServicesUseCase(this._repository);

  Stream<List<ServiceEntity>> call() => _repository.watchServices();
}
