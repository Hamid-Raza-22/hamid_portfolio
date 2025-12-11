import '../entities/profile_entity.dart';
import '../repositories/portfolio_repository.dart';

/// Use case for retrieving profile information.
class GetProfileUseCase {
  final PortfolioRepository _repository;

  GetProfileUseCase(this._repository);

  Future<ProfileEntity> call() async {
    return await _repository.getProfile();
  }
}
