// class AuditReportModel {
//   final String id;
//   final String facilityName;
//   final String activityType;
//   final String imageUrl;
//   final int complianceScore;
//   final String status;
//   final List<String> detectedViolations;
//   final List<String> correctiveActions;

//   AuditReportModel({
//     required this.id,
//     required this.facilityName,
//     required this.activityType,
//     required this.imageUrl,
//     required this.complianceScore,
//     required this.status,
//     required this.detectedViolations,
//     required this.correctiveActions,
//   });

//   factory AuditReportModel.fromJson(Map<String, dynamic> json) {
//     return AuditReportModel(
//       id: json['id'] ?? '',
//       facilityName: json['facility_name'] ?? '',
//       activityType: json['activity_type'] ?? '',
//       imageUrl: json['image_url'] ?? '',
//       complianceScore: json['compliance_score'] ?? 0,
//       status: json['status'] ?? 'under_review',
//       detectedViolations: List<String>.from(json['detected_violations'] ?? []),
//       correctiveActions: List<String>.from(json['corrective_actions'] ?? []),
//     );
//   }
// }

import 'package:frountend_app/features/audit/domain/entites/audit_report_entity.dart';


class AuditReportModel extends AuditReportEntity {
  const AuditReportModel({
    required super.id,
    required super.userId,
    required super.facilityName,
    required super.activityType,
    required super.imageUrl,
    required super.complianceScore,
    required super.status,
    required super.detectedViolations,
    required super.correctiveActions,
    required super.createdAt,
  });

  factory AuditReportModel.fromJson(Map<String, dynamic> json) {
    return AuditReportModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      facilityName: json['facility_name'] as String,
      activityType: json['activity_type'] as String,
      imageUrl: json['image_url'] as String,
      complianceScore: json['compliance_score'] as int,
      status: json['status'] as String,
      detectedViolations: List<String>.from(json['detected_violations'] ?? []),
      correctiveActions: List<String>.from(json['corrective_actions'] ?? []),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'facility_name': facilityName,
      'activity_type': activityType,
      'image_url': imageUrl,
      'compliance_score': complianceScore,
      'status': status,
      'detected_violations': detectedViolations,
      'corrective_actions': correctiveActions,
      'created_at': createdAt.toIso8601String(),
    };
  }
}