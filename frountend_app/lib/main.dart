import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frountend_app/core/constants/app_constants.dart';
import 'package:frountend_app/core/di/service_locator.dart';
import 'package:frountend_app/features/audit/presentation/cubit/audit_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/app_theme.dart';
import 'features/audit/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // تحميل متغيرة البيئة .env
  await dotenv.load(fileName: ".env");

  // 1. تهيئة Hive للتخزين المحلي
  await Hive.initFlutter();
  await Hive.openBox('audit_cache');

  // 2. تهيئة Supabase
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );

  // تهيئة محقن التبعيات GetIt
  await initServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    BlocProvider(
      create: (context) => sl<AuditCubit>(),
      child: MaterialApp(
        title: 'مُمْتَثِل الذكي',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const HomePage(),
      ),
    );
  }
}
