import '../entities/certification_entity.dart';
import '../repositories/portfolio_repository.dart';

/// Use case for retrieving certifications.
class GetCertificationsUseCase {
  final PortfolioRepository _repository;

  GetCertificationsUseCase(this._repository);

  Future<List<CertificationEntity>> call() async {
    return await _repository.getCertifications();
  }
}
