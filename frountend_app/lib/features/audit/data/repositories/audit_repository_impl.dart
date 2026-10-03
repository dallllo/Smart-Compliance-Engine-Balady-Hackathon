import 'package:frountend_app/features/audit/domain/entites/audit_report_entity.dart';
import '../../domain/repositories/audit_repository.dart';
import '../datasources/audit_remote_datasource.dart';

class AuditRepositoryImpl implements AuditRepository {
  final AuditRemoteDataSource remoteDataSource;

  AuditRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuditReportEntity> analyzeAudit({
    required String reportId,
    required String imageUrl,
    required String activityType,
    required String facilityName,
  }) async {
    final reportModel = await remoteDataSource.triggerAuditAnalysis(
      reportId: reportId,
      imageUrl: imageUrl,
      activityType: activityType, 
      facilityName: facilityName,
    );
    
    return reportModel;
  }
  @override
  Stream<List<AuditReportEntity>> getLatestReports() {
    final reportModels = remoteDataSource.getLatestReports();
    return reportModels;
  }
}