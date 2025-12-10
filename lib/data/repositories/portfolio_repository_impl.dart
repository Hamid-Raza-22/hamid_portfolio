import '../../domain/entities/nav_item_entity.dart';
import '../../domain/entities/portfolio_entity.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/entities/social_link_entity.dart';
import '../../domain/entities/stat_entity.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/local/portfolio_local_datasource.dart';

/// Implementation of the PortfolioRepository.
/// This follows the Repository Pattern, acting as a single source of truth.
class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource _localDataSource;

  PortfolioRepositoryImpl({
    required PortfolioLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  @override
  Future<List<ServiceEntity>> getServices() async {
    // In a real app, you might combine local and remote data here
    return _localDataSource.getServices();
  }

  @override
  Future<List<PortfolioEntity>> getPortfolioItems() async {
    return _localDataSource.getPortfolioItems();
  }

  @override
  Future<List<SocialLinkEntity>> getSocialLinks() async {
    return _localDataSource.getSocialLinks();
  }

  @override
  Future<List<StatEntity>> getStats() async {
    return _localDataSource.getStats();
  }

  @override
  Future<List<NavItemEntity>> getNavItems() async {
    return _localDataSource.getNavItems();
  }
}
