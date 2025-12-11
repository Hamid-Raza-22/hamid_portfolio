import '../entities/contact_info_entity.dart';
import '../repositories/portfolio_repository.dart';

/// Use case for retrieving contact information.
class GetContactInfoUseCase {
  final PortfolioRepository _repository;

  GetContactInfoUseCase(this._repository);

  Future<List<ContactInfoEntity>> call() async {
    return await _repository.getContactInfo();
  }
}
