// import 'package:flutter/material.dart';
// import '../../domain/entites/audit_report_entity.dart';

// // class ReportDetailsPage extends StatelessWidget {
// //   final AuditReportEntity report;

// //   const ReportDetailsPage({
// //     super.key,
// //     required this.report,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     final primaryColor = Theme.of(context).colorScheme.primary;

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('تفاصيل تقرير الامتثال'),
// //         centerTitle: true,
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // 1. عرض صورة المنشأة / الفحص الديناميكية
// //             ClipRRect(
// //               borderRadius: BorderRadius.circular(16),
// //               child: Container(
// //                 height: 220,
// //                 width: double.infinity,
// //                 color: Colors.grey.shade200,
// //                 child: report.imageUrl.isNotEmpty
// //                     ? Image.network(
// //                         report.imageUrl,
// //                         fit: BoxFit.cover,
// //                         loadingBuilder: (context, child, loadingProgress) {
// //                           if (loadingProgress == null) return child;
// //                           return const Center(
// //                             child: CircularProgressIndicator(),
// //                           );
// //                         },
// //                         errorBuilder: (context, error, stackTrace) {
// //                           return const Center(
// //                             child: Column(
// //                               mainAxisAlignment: MainAxisAlignment.center,
// //                               children: [
// //                                 Icon(Icons.broken_image_outlined,
// //                                     size: 48, color: Colors.grey),
// //                                 SizedBox(height: 8),
// //                                 Text('تعذر تحميل صورة الفحص',
// //                                     style: TextStyle(color: Colors.grey)),
// //                               ],
// //                             ),
// //                           );
// //                         },
// //                       )
// //                     : const Center(
// //                         child: Icon(Icons.image_not_supported_outlined,
// //                             size: 48, color: Colors.grey),
// //                       ),
// //               ),
// //             ),
// //             const SizedBox(height: 20),

// //             // 2. كارت معلومات المنشأة والنسبة
// //             Container(
// //               padding: const EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                 color: Theme.of(context).cardColor,
// //                 borderRadius: BorderRadius.circular(16),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(0.05),
// //                     blurRadius: 10,
// //                     offset: const Offset(0, 4),
// //                   ),
// //                 ],
// //               ),
// //               child: Row(
// //                 children: [
// //                   // مؤشر نسبة الامتثال الدائري
// //                   Stack(
// //                     alignment: Alignment.center,
// //                     children: [
// //                       SizedBox(
// //                         width: 75,
// //                         height: 75,
// //                         child: CircularProgressIndicator(
// //                           value: (report.complianceScore ?? 0) / 100,
// //                           strokeWidth: 8,
// //                           backgroundColor: Colors.grey.shade200,
// //                           color: _getScoreColor(report.complianceScore ?? 0),
// //                         ),
// //                       ),
// //                       Text(
// //                         '${report.complianceScore ?? 0}%',
// //                         style: const TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(width: 16),

// //                   // اسم المنشأة والحالة
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           report.facilityName,
// //                           style: const TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 4),
// //                         Text(
// //                           'نشاط المنشأة: ${report.activityType}',
// //                           style: TextStyle(
// //                             fontSize: 13,
// //                             color: Colors.grey.shade600,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 8),
// //                         _buildStatusBadge(report.status),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 24),

// //             // 3. قسم الملاحظات والامتثال التفصيلي
// //             const Text(
// //               'نتائج تقييم الذكاء الاصطناعي',
// //               style: TextStyle(
// //                 fontSize: 18,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             const SizedBox(height: 12),

// //             Container(
// //               width: double.infinity,
// //               padding: const EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                 color: Theme.of(context).cardColor,
// //                 borderRadius: BorderRadius.circular(16),
// //                 border: Border.all(color: Colors.grey.shade200),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       Icon(Icons.analytics_outlined, color: primaryColor),
// //                       const SizedBox(width: 8),
// //                       const Text(
// //                         'ملخص التقرير',
// //                         style: TextStyle(
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   // const Divider(height: 24),
// //                   // Text(
// //                   //   report.notes != null && report.notes!.isNotEmpty
// //                   //       ? report.notes!
// //                   //       : 'لم يتم تسجيل ملاحظات إضافية لهذا التقرير.',
// //                   //   style: const TextStyle(
// //                   //     fontSize: 14,
// //                   //     height: 1.6,
// //                   //   ),
// //                   // ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // لون شريط الامتثال حسب النسبة
// //   Color _getScoreColor(int score) {
// //     if (score >= 80) return Colors.green;
// //     if (score >= 50) return Colors.orange;
// //     return Colors.red;
// //   }

// //   // شارة حالة التقرير
// //   Widget _buildStatusBadge(String status) {
// //     bool isCompleted = status == 'completed';
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// //       decoration: BoxDecoration(
// //         color: isCompleted
// //             ? Colors.green.withOpacity(0.1)
// //             : Colors.orange.withOpacity(0.1),
// //         borderRadius: BorderRadius.circular(8),
// //       ),
// //       child: Text(
// //         isCompleted ? 'مكتمل' : 'قيد التقييم',
// //         style: TextStyle(
// //           color: isCompleted ? Colors.green.shade700 : Colors.orange.shade700,
// //           fontSize: 12,
// //           fontWeight: FontWeight.bold,
// //         ),
// //       ),
// //     );
// //   }
// // }



// // import 'dart:io';

// // class ReportDetailsPage extends StatelessWidget {
// //   final AuditReportEntity report;

// //   const ReportDetailsPage({
// //     super.key,
// //     required this.report,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     final primaryColor = Theme.of(context).colorScheme.primary;

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('تفاصيل تقرير الامتثال'),
// //         centerTitle: true,
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // 1. عرض صورة المنشأة / الفحص الملتقطة أو المرفوعة
// //             ClipRRect(
// //               borderRadius: BorderRadius.circular(16),
// //               child: Container(
// //                 height: 220,
// //                 width: double.infinity,
// //                 color: Colors.grey.shade200,
// //                 child: _buildReportImage(report.imageUrl),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             Container(
// //               padding: const EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                 color: Theme.of(context).cardColor,
// //                 borderRadius: BorderRadius.circular(16),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black.withValues(alpha: 0.05),
// //                     blurRadius: 10,
// //                     offset: const Offset(0, 4),
// //                   ),
// //                 ],
// //               ),
// //               child: Row(
// //                 children: [
// //                   // مؤشر نسبة الامتثال الدائري
// //                   Stack(
// //                     alignment: Alignment.center,
// //                     children: [
// //                       SizedBox(
// //                         width: 75,
// //                         height: 75,
// //                         child: CircularProgressIndicator(
// //                           value: (report.complianceScore) / 100,
// //                           strokeWidth: 8,
// //                           backgroundColor: Colors.grey.shade200,
// //                           color: _getScoreColor(report.complianceScore),
// //                         ),
// //                       ),
// //                       Text(
// //                         '${report.complianceScore}%',
// //                         style: const TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(width: 16),

// //                   // اسم المنشأة والحالة
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           report.facilityName.isEmpty
// //                               ? 'منشأة بدون اسم'
// //                               : report.facilityName,
// //                           style: const TextStyle(
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 4),
// //                         Text(
// //                           'نشاط المنشأة: ${report.activityType}',
// //                           style: TextStyle(
// //                             fontSize: 13,
// //                             color: Colors.grey.shade600,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 8),
// //                         _buildStatusBadge(report.status),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 24),

// //             // 3. قسم الملاحظات وتوصيات الذكاء الاصطناعي
// //             const Text(
// //               'نتائج تقييم الذكاء الاصطناعي',
// //               style: TextStyle(
// //                 fontSize: 18,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             const SizedBox(height: 12),

// //             Container(
// //               width: double.infinity,
// //               padding: const EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                 color: Theme.of(context).cardColor,
// //                 borderRadius: BorderRadius.circular(16),
// //                 border: Border.all(color: Colors.grey.shade200),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       Icon(Icons.analytics_outlined, color: primaryColor),
// //                       const SizedBox(width: 8),
// //                       const Text(
// //                         'ملخص التقرير والانتهاكات',
// //                         style: TextStyle(
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   // const Divider(height: 24),
// //                   // Text(
// //                   //   report.notes != null && report.notes!.isNotEmpty
// //                   //       ? report.notes!
// //                   //       : 'لم يتم تسجيل ملاحظات إضافية لهذا التقرير.',
// //                   //   style: const TextStyle(
// //                   //     fontSize: 14,
// //                   //     height: 1.6,
// //                   //   ),
// //                   // ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // ودجت ذكية لعرض الصورة حسب نوع الرابط (شبكة أو ملف محلي)
// //   Widget _buildReportImage(String imageUrl) {
// //     if (imageUrl.isEmpty) {
// //       return const Center(
// //         child: Icon(Icons.image_not_supported_outlined,
// //             size: 48, color: Colors.grey),
// //       );
// //     }

// //     // إذا كانت الصورة ملتقطة محلياً من الكاميرا
// //     if (!imageUrl.startsWith('http')) {
// //       return Image.file(
// //         File(imageUrl),
// //         fit: BoxFit.cover,
// //         errorBuilder: (context, error, stackTrace) => const Center(
// //           child: Icon(Icons.broken_image_outlined, size: 48, color: Colors.grey),
// //         ),
// //       );
// //     }

// //     // إذا كانت الصورة مرفوعة ورابطها شبكي من Supabase أو Unsplash
// //     return Image.network(
// //       imageUrl,
// //       fit: BoxFit.cover,
// //       loadingBuilder: (context, child, loadingProgress) {
// //         if (loadingProgress == null) return child;
// //         return const Center(child: CircularProgressIndicator());
// //       },
// //       errorBuilder: (context, error, stackTrace) {
// //         return const Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Icon(Icons.broken_image_outlined, size: 48, color: Colors.grey),
// //               SizedBox(height: 8),
// //               Text('تعذر تحميل صورة الفحص', style: TextStyle(color: Colors.grey)),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Color _getScoreColor(int score) {
// //     if (score >= 80) return Colors.green;
// //     if (score >= 50) return Colors.orange;
// //     return Colors.red;
// //   }

// //   Widget _buildStatusBadge(String status) {
// //     bool isCompleted = status == 'completed';
// //     final badgeColor = isCompleted ? Colors.green : Colors.orange;

// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// //       decoration: BoxDecoration(
// //         color: badgeColor.withValues(alpha: 0.1),
// //         borderRadius: BorderRadius.circular(8),
// //       ),
// //       child: Text(
// //         isCompleted ? 'مكتمل' : 'قيد التقييم...',
// //         style: TextStyle(
// //           color: badgeColor,
// //           fontSize: 12,
// //           fontWeight: FontWeight.bold,
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:io';

// class ReportDetailsPage extends StatelessWidget {
//   final AuditReportEntity report;

//   const ReportDetailsPage({
//     super.key,
//     required this.report,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final primaryColor = Theme.of(context).colorScheme.primary;
//     final accentGold = Theme.of(context).colorScheme.secondary;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('تفاصيل تقرير الامتثال'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 1. عرض صورة المنشأة
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Container(
//                 height: 220,
//                 width: double.infinity,
//                 color: Colors.grey.shade200,
//                 child: _buildReportImage(report.imageUrl),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // 2. بطاقة معلومات المنشأة
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   // مؤشر نسبة الامتثال الدائري باللون الذهبي/الأخضر
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       SizedBox(
//                         width: 75,
//                         height: 75,
//                         child: CircularProgressIndicator(
//                           value: (report.complianceScore) / 100,
//                           strokeWidth: 8,
//                           backgroundColor: Colors.grey.shade200,
//                           color: _getScoreColor(
//                             report.complianceScore,
//                             primaryColor,
//                             accentGold,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         '${report.complianceScore}%',
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(width: 16),

//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           report.facilityName.isEmpty
//                               ? 'منشأة بدون اسم'
//                               : report.facilityName,
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'نشاط المنشأة: ${report.activityType}',
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         _buildStatusBadge(report.status, primaryColor),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),

//             // 3. نتائج وتقييم الذكاء الاصطناعي
//             const Text(
//               'نتائج تقييم الذكاء الاصطناعي',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),

//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//                   color: primaryColor.withValues(alpha: 0.15),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.analytics_outlined, color: primaryColor),
//                       const SizedBox(width: 8),
//                       const Text(
//                         'ملخص التقرير والانتهاكات',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   // const Divider(height: 24),
//                   // Text(
//                   //   report.notes != null && report.notes!.isNotEmpty
//                   //       ? report.notes!
//                   //       : 'لم يتم تسجيل ملاحظات إضافية لهذا التقرير.',
//                   //   style: const TextStyle(
//                   //     fontSize: 14,
//                   //     height: 1.6,
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildReportImage(String imageUrl) {
//     if (imageUrl.isEmpty) {
//       return const Center(
//         child: Icon(Icons.image_not_supported_outlined,
//             size: 48, color: Colors.grey),
//       );
//     }

//     if (!imageUrl.startsWith('http')) {
//       return Image.file(
//         File(imageUrl),
//         fit: BoxFit.cover,
//         errorBuilder: (context, error, stackTrace) => const Center(
//           child: Icon(Icons.broken_image_outlined, size: 48, color: Colors.grey),
//         ),
//       );
//     }

//     return Image.network(
//       imageUrl,
//       fit: BoxFit.cover,
//       loadingBuilder: (context, child, loadingProgress) {
//         if (loadingProgress == null) return child;
//         return const Center(child: CircularProgressIndicator());
//       },
//       errorBuilder: (context, error, stackTrace) {
//         return const Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.broken_image_outlined, size: 48, color: Colors.grey),
//               SizedBox(height: 8),
//               Text('تعذر تحميل صورة الفحص', style: TextStyle(color: Colors.grey)),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Color _getScoreColor(int score, Color primaryColor, Color accentGold) {
//     if (score >= 80) return primaryColor;
//     if (score >= 50) return accentGold;
//     return Colors.red.shade700;
//   }

//   Widget _buildStatusBadge(String status, Color primaryColor) {
//     bool isCompleted = status == 'completed';
//     final badgeColor = isCompleted ? primaryColor : Colors.orange.shade800;

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: badgeColor.withValues(alpha: 0.1),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         isCompleted ? 'مكتمل' : 'قيد التقييم...',
//         style: TextStyle(
//           color: badgeColor,
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import '../../domain/entites/audit_report_entity.dart';

class ReportDetailsPage extends StatelessWidget {
  final AuditReportEntity report;

  const ReportDetailsPage({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final accentGold = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل تقرير الامتثال'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. صورة المنشأة
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 220,
                width: double.infinity,
                color: Colors.grey.shade200,
                child: _buildReportImage(report.imageUrl),
              ),
            ),
            const SizedBox(height: 20),

            // 2. كارت النسبة والمعلومات الرئيسية
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 75,
                        height: 75,
                        child: CircularProgressIndicator(
                          value: (report.complianceScore) / 100,
                          strokeWidth: 8,
                          backgroundColor: Colors.grey.shade200,
                          color: _getScoreColor(
                            report.complianceScore,
                            primaryColor,
                            accentGold,
                          ),
                        ),
                      ),
                      Text(
                        '${report.complianceScore}%',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report.facilityName.isEmpty
                              ? 'منشأة بدون اسم'
                              : report.facilityName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'نشاط المنشأة: ${report.activityType}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildStatusBadge(report.status, primaryColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 3. نتائج تقييم الذكاء الاصطناعي
            Row(
              children: [
                Icon(Icons.analytics_outlined, color: primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'نتائج تقييم الذكاء الاصطناعي',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // قائمة المخالفات والانتهاكات المكتشفة
            _buildSectionCard(
              context: context,
              title: 'المخالفات والانتهاكات المكتشفة',
              icon: Icons.warning_amber_rounded,
              iconColor: Colors.amber.shade900,
              items: report.detectedViolations,
              emptyMessage: 'لم يتم رصد أي مخالفات في هذا الفحص.',
            ),

            const SizedBox(height: 16),

            // قائمة الإجراءات التصحيحية الموصى بها
            _buildSectionCard(
              context: context,
              title: 'الإجراءات التصحيحية الموصى بها',
              icon: Icons.build_circle_outlined,
              iconColor: primaryColor,
              items: report.correctiveActions,
              emptyMessage: 'لا توجد إجراءات تصحيحية مطلوبة.',
            ),
          ],
        ),
      ),
    );
  }

  // ودجت لبناء كروت التفاصيل القابلة للتكرار (للمخالفات والإجراءات التصحيحية)
  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<String> items,
    required String emptyMessage,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                emptyMessage,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            )
          else
            Column(
              children: items.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: iconColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildReportImage(String imageUrl) {
    if (imageUrl.isEmpty) {
      return const Center(
        child: Icon(Icons.image_not_supported_outlined,
            size: 48, color: Colors.grey),
      );
    }

    if (!imageUrl.startsWith('http')) {
      return Image.file(
        File(imageUrl),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(Icons.broken_image_outlined, size: 48, color: Colors.grey),
        ),
      );
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.broken_image_outlined, size: 48, color: Colors.grey),
              SizedBox(height: 8),
              Text('تعذر تحميل صورة الفحص', style: TextStyle(color: Colors.grey)),
            ],
          ),
        );
      },
    );
  }

  Color _getScoreColor(int score, Color primaryColor, Color accentGold) {
    if (score >= 80) return primaryColor;
    if (score >= 50) return accentGold;
    return Colors.red.shade700;
  }

  Widget _buildStatusBadge(String status, Color primaryColor) {
    bool isCompleted = status == 'completed';
    final badgeColor = isCompleted ? primaryColor : Colors.orange.shade800;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isCompleted ? 'مكتمل' : 'قيد التقييم...',
        style: TextStyle(
          color: badgeColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}