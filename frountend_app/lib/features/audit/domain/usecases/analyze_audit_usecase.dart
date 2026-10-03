
import 'package:frountend_app/features/audit/domain/entites/audit_report_entity.dart';

import '../repositories/audit_repository.dart';

class AnalyzeAuditUseCase {
  final AuditRepository repository;

  AnalyzeAuditUseCase(this.repository);

  Future<AuditReportEntity> call({
    required String reportId,
    required String imageUrl,
    required String activityType,
    required String facilityName,
  }) async {
    return await repository.analyzeAudit(
      reportId: reportId,
      imageUrl: imageUrl,
      activityType: activityType, 
      facilityName: facilityName,
    );
  }

  Stream <List<AuditReportEntity>> getLatestReports() {
    final reportModels = repository.getLatestReports();
    return reportModels;
  }
}