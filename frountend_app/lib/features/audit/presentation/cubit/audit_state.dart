import 'package:frountend_app/features/audit/domain/entites/audit_report_entity.dart';
abstract class AuditState {}

class AuditInitialState extends AuditState {}
class AuditLoadingState extends AuditState {}

class AuditReportsLoadedState extends AuditState {
  final List<AuditReportEntity> reports;
  AuditReportsLoadedState(this.reports);
}

class AuditSuccessState extends AuditState {
  final AuditReportEntity report;
  AuditSuccessState(this.report);
}

class AuditErrorState extends AuditState {
  final String message;
  AuditErrorState(this.message);
}
