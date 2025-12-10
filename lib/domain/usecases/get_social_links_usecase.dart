import '../entities/social_link_entity.dart';
import '../repositories/portfolio_repository.dart';

/// Use case for retrieving social links.
class GetSocialLinksUseCase {
  final PortfolioRepository _repository;

  GetSocialLinksUseCase(this._repository);

  Future<List<SocialLinkEntity>> call() async {
    return await _repository.getSocialLinks();
  }
}
