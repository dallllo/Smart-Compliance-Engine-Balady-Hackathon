import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/analyze_audit_usecase.dart';
import 'audit_state.dart';

// class AuditCubit extends Cubit<AuditState> {
//   final AnalyzeAuditUseCase analyzeAuditUseCase;

//   AuditCubit({required this.analyzeAuditUseCase}) : super(AuditInitialState()){
//   // Future<void> runAudit;
//   // await analyzeAuditUseCase.getLatestReports();
//   }

//   Future<void> runAudit({
//     required String reportId,
//     required String facilityName,
//     required String imageUrl,
//     required String activityType,
//   }) async {
//     emit(AuditLoadingState());
//     try {
//       final report = await analyzeAuditUseCase.call(
//         reportId: reportId,
//         facilityName: facilityName, 
//         imageUrl: imageUrl,
//         activityType: activityType,
//       );
//       emit(AuditSuccessState(report));
//     } catch (e) {
//       emit(AuditErrorState(e.toString()));
//     }
//   }
//   // // دالة جلب قائمة أحدث التقارير
//   // Stream <void> fetchLatestReports() {
//   //   emit(AuditLoadingState());
//   //   try {
//   //     final reports = analyzeAuditUseCase.getLatestReports();
//   //     emit(AuditReportsLoadedState(reports));
//   //   } catch (e) {
//   //     emit(AuditErrorState(e.toString()));
//   //   }
//   // }

//   Future<void> fetchLatestReports() async {
//   emit(AuditLoadingState());
//   try {
//     final reports = await analyzeAuditUseCase.getLatestReports();
//     emit(AuditReportsLoadedState(reports));
//   } catch (e) {
//     emit(AuditErrorState(e.toString()));
//   }
// }

//   }


import 'dart:async';
class AuditCubit extends Cubit<AuditState> {
  final AnalyzeAuditUseCase analyzeAuditUseCase;
  StreamSubscription? reportsSubscription;

  AuditCubit({required this.analyzeAuditUseCase}) : super(AuditInitialState());

  // دالة الاستماع التدفق اللحظي (Stream)
  void fetchLatestReports() {
    emit(AuditLoadingState());

    // إلغاء الاستماع القديم إن وجد لتفادي التكرار
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