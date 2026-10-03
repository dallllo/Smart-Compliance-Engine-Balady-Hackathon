// import 'package:equatable/equatable.dart';

// abstract class AuditState extends Equatable {
//   const AuditState();

//   @override
//   List<Object?> get props => [];
// }

// class AuditInitial extends AuditState {}

// class AuditLoading extends AuditState {}

// class AuditReportsLoaded extends AuditState {
//   final List<Map<String, dynamic>> reports;

//   const AuditReportsLoaded(this.reports);

//   @override
//   List<Object?> get props => [reports];
// }

// class AuditSubmitting extends AuditState {}

// class AuditSuccess extends AuditState {
//   final String reportId;

//   const AuditSuccess(this.reportId);

//   @override
//   List<Object?> get props => [reportId];
// }

// class AuditError extends AuditState {
//   final String message;

//   const AuditError(this.message);

//   @override
//   List<Object?> get props => [message];
// }



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