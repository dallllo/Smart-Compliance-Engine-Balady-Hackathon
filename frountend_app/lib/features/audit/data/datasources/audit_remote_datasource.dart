import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/audit_report_model.dart';

abstract class AuditRemoteDataSource {
  Future<AuditReportModel> triggerAuditAnalysis({
    required String reportId,
    required String facilityName,
    required String imageUrl,
    required String activityType,
  });
  Stream<List<AuditReportModel>> getLatestReports();
}

class AuditRemoteDataSourceImpl implements AuditRemoteDataSource {
  final Dio dio;
  final SupabaseClient supabaseClient;

  AuditRemoteDataSourceImpl({
    required this.dio,
    required this.supabaseClient,
  });

  @override
  Future<AuditReportModel> triggerAuditAnalysis({
    required String reportId,
    required String imageUrl,
    required String activityType,
    required String facilityName,
  }) async {
    final userId = supabaseClient.auth.currentUser?.id;
    final response = await dio.post(
      '${AppConstants.fastApiBaseUrl}/api/v1/analyze-audit',
      data: {
        'report_id': reportId,
        'user_id': userId,
        'image_url': imageUrl,
        'facility_name': facilityName,
        'activity_type': activityType,
      },
    );

    if (response.statusCode == 200) {
      await Future.delayed(const Duration(milliseconds: 500));
      final data = await supabaseClient
          .from('audit_reports')
          .select()
          .eq('id', reportId)
          .maybeSingle();

          if (data == null) {
            throw Exception('لم يتم العثور على التقرير رقم ($reportId) في Supabase. تأكدي من حفظ FastAPI للبيانات بنفس الـ ID.');
          }

      return AuditReportModel.fromJson(data);
    } else {
      throw Exception('فشل في بدء عملية الفحص عبر السيرفر');
    }
  }

  @override
  Stream<List<AuditReportModel>> getLatestReports() {
    final userId = "e5390c18-fed2-47f4-9b53-0bfd8d14a91c"; 
    
    return supabaseClient
      .from('audit_reports')
      .stream(primaryKey: ['id'])
      .eq('user_id', userId)
      .order('created_at', ascending: false)
      .map((data) => data.map((json) => AuditReportModel.fromJson(json)).toList());
  }
}

