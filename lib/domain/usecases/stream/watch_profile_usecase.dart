import '../../entities/entities.dart';
import '../../repositories/portfolio_repository_stream.dart';

/// Use case for watching profile in real-time.
class WatchProfileUseCase {
  final PortfolioRepositoryStream _repository;

  WatchProfileUseCase(this._repository);

  Stream<ProfileEntity> call() => _repository.watchProfile();
}
