import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Import Data Layer
import '../../features/audit/data/datasources/audit_remote_datasource.dart';
import '../../features/audit/data/repositories/audit_repository_impl.dart';

// Import Domain Layer
import '../../features/audit/domain/repositories/audit_repository.dart';
import '../../features/audit/domain/usecases/analyze_audit_usecase.dart';

// Import Presentation Layer
import '../../features/audit/presentation/cubit/audit_cubit.dart';

final sl = GetIt.instance; // sl تعني Service Locator

Future<void> initServiceLocator() async {
  // 1. External & Core Dependencies (الخدمات الخارجية)
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // 2. Data Sources
  sl.registerLazySingleton<AuditRemoteDataSource>(
    () => AuditRemoteDataSourceImpl(
      dio: sl<Dio>(),
      supabaseClient: sl<SupabaseClient>(),
    ),
  );

  // 3. Repositories
  sl.registerLazySingleton<AuditRepository>(
    () => AuditRepositoryImpl(
      remoteDataSource: sl<AuditRemoteDataSource>(),
    ),
  );

  // 4. Use Cases
  sl.registerLazySingleton<AnalyzeAuditUseCase>(
    () => AnalyzeAuditUseCase(sl<AuditRepository>()),
  );

  // 5. Cubits (استخدام Factory لإنشاء النسخة عند الحاجة لها)
  sl.registerFactory<AuditCubit>(
    () => AuditCubit(analyzeAuditUseCase: sl<AnalyzeAuditUseCase>()),
  );
}