import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/analyze_audit_usecase.dart';
import 'audit_state.dart';

import 'dart:async';
class AuditCubit extends Cubit<AuditState> {
  final AnalyzeAuditUseCase analyzeAuditUseCase;
  StreamSubscription? reportsSubscription;

  AuditCubit({required this.analyzeAuditUseCase}) : super(AuditInitialState());
  void fetchLatestReports() {
    emit(AuditLoadingState());

    reportsSubscription?.cancel();

    reportsSubscription = analyzeAuditUseCase.getLatestReports().listen(
      (reports) {
        emit(AuditReportsLoadedState(reports));
      },
      onError: (error) {
        emit(AuditErrorState(error.toString()));
      },
    );
  }

  Future<void> runAudit({
    required String reportId,
    required String facilityName,
    required String imageUrl,
    required String activityType,
  }) async {
    emit(AuditLoadingState());
    try {
      final report = await analyzeAuditUseCase.call(
        reportId: reportId,
        facilityName: facilityName, 
        imageUrl: imageUrl,
        activityType: activityType,
      );
      emit(AuditSuccessState(report));
    } catch (e) {
      emit(AuditErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    reportsSubscription?.cancel();
    return super.close();
  }
}
