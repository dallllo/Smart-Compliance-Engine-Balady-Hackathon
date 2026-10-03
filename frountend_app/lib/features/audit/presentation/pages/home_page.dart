import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frountend_app/features/audit/domain/entites/audit_report_entity.dart';
import 'package:frountend_app/features/audit/presentation/pages/report_details_page.dart';
import '../cubit/audit_cubit.dart';
import '../cubit/audit_state.dart';
import 'new_audit_page.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<AuditCubit>().fetchLatestReports();
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('منصة مُمْتَثِل الذكي'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AuditCubit>().fetchLatestReports();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildComplianceOverviewCard(context),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NewAuditPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_a_photo_outlined),
                      label: const Text('فحص منشأة جديد'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'آخر تقارير الامتثال',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              BlocBuilder<AuditCubit, AuditState>(
                builder: (context, state) {
                  if (state is AuditLoadingState) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is AuditReportsLoadedState) {
                    if (state.reports.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text('لا توجد تقارير حالية'),
                        ),
                      );
                    }

                    return Column(
                      children: state.reports.map((report) {
                        return _buildReportItem(context, report);
                      }).toList(),
                    );
                  }

                  if (state is AuditErrorState) {
                    return Text('خطأ: ${state.message}');
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComplianceOverviewCard(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final accentGold = theme.colorScheme.secondary;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey.shade300,
                  color: accentGold, // لمسة اللون الذهبي للنسب المؤشرية
                ),
              ),
              Text(
                '85%',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'متوسط جاهزية المنشآت',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'حالة المنشآت: جاهزة بنسبة عالية مع وجود ملاحظات تصحيحية بسيطة.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportItem(BuildContext context, AuditReportEntity report) {
    Color statusColor;
    String statusText;

    final score = report.complianceScore;
    final status = report.status;

    if (status == 'under_review' || status == 'pending') {
      statusColor = Colors.blue.shade700;
      statusText = 'قيد التقييم...';
    } else if (score >= 80 || status == 'compliant') {
      statusColor = Theme.of(context).colorScheme.primary;
      statusText = 'امتثال $score%';
    } else {
      statusColor = Colors.orange.shade800;
      statusText = 'امتثال $score%';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReportDetailsPage(report: report),
            ),
          );
        },
        leading: CircleAvatar(
          backgroundColor: statusColor.withValues(alpha: 0.1),
          child: Icon(
            status == 'under_review' ? Icons.hourglass_top : Icons.fact_check,
            color: statusColor,
          ),
        ),
        title: Text(
          report.facilityName.isEmpty ? 'منشأة بدون اسم' : report.facilityName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('النشاط: ${report.activityType}'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
