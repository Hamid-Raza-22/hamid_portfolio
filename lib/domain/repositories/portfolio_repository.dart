import '../entities/portfolio_entity.dart';
import '../entities/service_entity.dart';
import '../entities/social_link_entity.dart';
import '../entities/stat_entity.dart';
import '../entities/nav_item_entity.dart';

/// Abstract repository interface for portfolio data.
/// This defines the contract that data layer must implement.
abstract class PortfolioRepository {
  /// Get all services offered
  Future<List<ServiceEntity>> getServices();

  /// Get all portfolio projects
  Future<List<PortfolioEntity>> getPortfolioItems();

  /// Get all social media links
  Future<List<SocialLinkEntity>> getSocialLinks();

  /// Get statistics/achievements
  Future<List<StatEntity>> getStats();

  /// Get navigation items
  Future<List<NavItemEntity>> getNavItems();
}
