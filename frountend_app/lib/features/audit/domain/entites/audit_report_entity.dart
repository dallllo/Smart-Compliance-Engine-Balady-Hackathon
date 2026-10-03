class AuditReportEntity {
  final String id;
  final String userId;
  final String facilityName;
  final String activityType;
  final String imageUrl;
  final int complianceScore;
  final String status; // compliant, non_compliant, under_review
  final List<String> detectedViolations;
  final List<String> correctiveActions;
  final DateTime createdAt;

  const AuditReportEntity({
    required this.id,
    required this.userId,
    required this.facilityName,
    required this.activityType,
    required this.imageUrl,
    required this.complianceScore,
    required this.status,
    required this.detectedViolations,
    required this.correctiveActions,
    required this.createdAt,
  });
}