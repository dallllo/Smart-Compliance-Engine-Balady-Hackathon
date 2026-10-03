import 'package:frountend_app/features/audit/domain/entites/audit_report_entity.dart';


abstract class AuditRepository {
  Future<AuditReportEntity> analyzeAudit({
    required String reportId,
    required String facilityName,
    required String imageUrl,
    required String activityType,
  });
  Stream<List<AuditReportEntity>> getLatestReports();
}