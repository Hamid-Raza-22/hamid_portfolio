import '../entities/project_detail_entity.dart';
import '../repositories/portfolio_repository.dart';

/// Use case for retrieving detailed project information.
class GetProjectDetailsUseCase {
  final PortfolioRepository _repository;

  GetProjectDetailsUseCase(this._repository);

  Future<List<ProjectDetailEntity>> call() async {
    return await _repository.getProjectDetails();
  }
}
