import '../../entities/entities.dart';
import '../../repositories/portfolio_repository_stream.dart';

// ============ SERVICE CRUD USE CASES ============

class AddServiceUseCase {
  final PortfolioRepositoryStream _repository;
  AddServiceUseCase(this._repository);
  Future<void> call(ServiceEntity service) => _repository.addService(service);
}

class UpdateServiceUseCase {
  final PortfolioRepositoryStream _repository;
  UpdateServiceUseCase(this._repository);
  Future<void> call(ServiceEntity service) => _repository.updateService(service);
}

class DeleteServiceUseCase {
  final PortfolioRepositoryStream _repository;
  DeleteServiceUseCase(this._repository);
  Future<void> call(String id) => _repository.deleteService(id);
}

// ============ PORTFOLIO CRUD USE CASES ============

class AddPortfolioItemUseCase {
  final PortfolioRepositoryStream _repository;
  AddPortfolioItemUseCase(this._repository);
  Future<void> call(PortfolioEntity item) => _repository.addPortfolioItem(item);
}

class UpdatePortfolioItemUseCase {
  final PortfolioRepositoryStream _repository;
  UpdatePortfolioItemUseCase(this._repository);
  Future<void> call(PortfolioEntity item) => _repository.updatePortfolioItem(item);
}

class DeletePortfolioItemUseCase {
  final PortfolioRepositoryStream _repository;
  DeletePortfolioItemUseCase(this._repository);
  Future<void> call(String id) => _repository.deletePortfolioItem(id);
}

// ============ EXPERIENCE CRUD USE CASES ============

class AddExperienceUseCase {
  final PortfolioRepositoryStream _repository;
  AddExperienceUseCase(this._repository);
  Future<void> call(ExperienceEntity experience) => _repository.addExperience(experience);
}

class UpdateExperienceUseCase {
  final PortfolioRepositoryStream _repository;
  UpdateExperienceUseCase(this._repository);
  Future<void> call(ExperienceEntity experience) => _repository.updateExperience(experience);
}

class DeleteExperienceUseCase {
  final PortfolioRepositoryStream _repository;
  DeleteExperienceUseCase(this._repository);
  Future<void> call(String id) => _repository.deleteExperience(id);
}

// ============ PROFILE USE CASE ============

class UpdateProfileUseCase {
  final PortfolioRepositoryStream _repository;
  UpdateProfileUseCase(this._repository);
  Future<void> call(ProfileEntity profile) => _repository.updateProfile(profile);
}

// ============ SOCIAL LINK CRUD USE CASES ============

class AddSocialLinkUseCase {
  final PortfolioRepositoryStream _repository;
  AddSocialLinkUseCase(this._repository);
  Future<void> call(SocialLinkEntity link) => _repository.addSocialLink(link);
}

class UpdateSocialLinkUseCase {
  final PortfolioRepositoryStream _repository;
  UpdateSocialLinkUseCase(this._repository);
  Future<void> call(SocialLinkEntity link) => _repository.updateSocialLink(link);
}

class DeleteSocialLinkUseCase {
  final PortfolioRepositoryStream _repository;
  DeleteSocialLinkUseCase(this._repository);
  Future<void> call(String id) => _repository.deleteSocialLink(id);
}

// ============ STAT CRUD USE CASES ============

class AddStatUseCase {
  final PortfolioRepositoryStream _repository;
  AddStatUseCase(this._repository);
  Future<void> call(StatEntity stat) => _repository.addStat(stat);
}

class UpdateStatUseCase {
  final PortfolioRepositoryStream _repository;
  UpdateStatUseCase(this._repository);
  Future<void> call(StatEntity stat) => _repository.updateStat(stat);
}

class DeleteStatUseCase {
  final PortfolioRepositoryStream _repository;
  DeleteStatUseCase(this._repository);
  Future<void> call(String id) => _repository.deleteStat(id);
}

// ============ EDUCATION CRUD USE CASES ============

class AddEducationUseCase {
  final PortfolioRepositoryStream _repository;
  AddEducationUseCase(this._repository);
  Future<void> call(EducationEntity education) => _repository.addEducation(education);
}

class UpdateEducationUseCase {
  final PortfolioRepositoryStream _repository;
  UpdateEducationUseCase(this._repository);
  Future<void> call(EducationEntity education) => _repository.updateEducation(education);
}

class DeleteEducationUseCase {
  final PortfolioRepositoryStream _repository;
  DeleteEducationUseCase(this._repository);
  Future<void> call(String id) => _repository.deleteEducation(id);
}

// ============ CERTIFICATION CRUD USE CASES ============

class AddCertificationUseCase {
  final PortfolioRepositoryStream _repository;
  AddCertificationUseCase(this._repository);
  Future<void> call(CertificationEntity certification) => _repository.addCertification(certification);
}

class UpdateCertificationUseCase {
  final PortfolioRepositoryStream _repository;
  UpdateCertificationUseCase(this._repository);
  Future<void> call(CertificationEntity certification) => _repository.updateCertification(certification);
}

class DeleteCertificationUseCase {
  final PortfolioRepositoryStream _repository;
  DeleteCertificationUseCase(this._repository);
  Future<void> call(String id) => _repository.deleteCertification(id);
}

// ============ ACHIEVEMENT CRUD USE CASES ============

class AddAchievementUseCase {
  final PortfolioRepositoryStream _repository;
  AddAchievementUseCase(this._repository);
  Future<void> call(AchievementEntity achievement) => _repository.addAchievement(achievement);
}

class UpdateAchievementUseCase {
  final PortfolioRepositoryStream _repository;
  UpdateAchievementUseCase(this._repository);
  Future<void> call(AchievementEntity achievement) => _repository.updateAchievement(achievement);
}

class DeleteAchievementUseCase {
  final PortfolioRepositoryStream _repository;
  DeleteAchievementUseCase(this._repository);
  Future<void> call(String id) => _repository.deleteAchievement(id);
}

// ============ EXPERTISE CRUD USE CASES ============

class AddExpertiseUseCase {
  final PortfolioRepositoryStream _repository;
  AddExpertiseUseCase(this._repository);
  Future<void> call(ExpertiseEntity expertise) => _repository.addExpertise(expertise);
}

class UpdateExpertiseUseCase {
  final PortfolioRepositoryStream _repository;
  UpdateExpertiseUseCase(this._repository);
  Future<void> call(ExpertiseEntity expertise) => _repository.updateExpertise(expertise);
}

class DeleteExpertiseUseCase {
  final PortfolioRepositoryStream _repository;
  DeleteExpertiseUseCase(this._repository);
  Future<void> call(String id) => _repository.deleteExpertise(id);
}

// ============ CONTACT INFO CRUD USE CASES ============

class AddContactInfoUseCase {
  final PortfolioRepositoryStream _repository;
  AddContactInfoUseCase(this._repository);
  Future<void> call(ContactInfoEntity info) => _repository.addContactInfo(info);
}

class UpdateContactInfoUseCase {
  final PortfolioRepositoryStream _repository;
  UpdateContactInfoUseCase(this._repository);
  Future<void> call(ContactInfoEntity info) => _repository.updateContactInfo(info);
}

class DeleteContactInfoUseCase {
  final PortfolioRepositoryStream _repository;
  DeleteContactInfoUseCase(this._repository);
  Future<void> call(String id) => _repository.deleteContactInfo(id);
}

// ============ PROJECT DETAIL CRUD USE CASES ============

class AddProjectDetailUseCase {
  final PortfolioRepositoryStream _repository;
  AddProjectDetailUseCase(this._repository);
  Future<void> call(ProjectDetailEntity project) => _repository.addProjectDetail(project);
}

class UpdateProjectDetailUseCase {
  final PortfolioRepositoryStream _repository;
  UpdateProjectDetailUseCase(this._repository);
  Future<void> call(ProjectDetailEntity project) => _repository.updateProjectDetail(project);
}

class DeleteProjectDetailUseCase {
  final PortfolioRepositoryStream _repository;
  DeleteProjectDetailUseCase(this._repository);
  Future<void> call(String id) => _repository.deleteProjectDetail(id);
}

// ============ SEED DATA USE CASE ============

class SeedInitialDataUseCase {
  final PortfolioRepositoryStream _repository;
  SeedInitialDataUseCase(this._repository);
  Future<void> call() => _repository.seedInitialData();
}

// ============ NAV ITEM CRUD USE CASES ============

class AddNavItemUseCase {
  final PortfolioRepositoryStream _repository;
  AddNavItemUseCase(this._repository);
  Future<void> call(NavItemEntity item) => _repository.addNavItem(item);
}

class UpdateNavItemUseCase {
  final PortfolioRepositoryStream _repository;
  UpdateNavItemUseCase(this._repository);
  Future<void> call(NavItemEntity item) => _repository.updateNavItem(item);
}

class DeleteNavItemUseCase {
  final PortfolioRepositoryStream _repository;
  DeleteNavItemUseCase(this._repository);
  Future<void> call(String id) => _repository.deleteNavItem(id);
}
