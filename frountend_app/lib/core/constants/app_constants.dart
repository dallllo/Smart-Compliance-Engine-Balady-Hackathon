// class AppConstants {
//   static const String supabaseUrl = 'https://bcepdmpvxhjtyovfubmm.supabase.co';
//   static const String supabaseAnonKey = 'sb_publishable_RiB4dwwpZXeJLsUM_IiL3g_CdfeDRGd';
  
//   // // رابط سيرفر FastAPI (في حال التجربة على محاكي iOS استخدم 127.0.0.1 وفي أندرويد 10.0.2.2)
//   // static const String fastApiBaseUrl = 'http://127.0.0.1:8000';
  
//   // استخدمي 10.0.2.2 لأجهزة أندرويد لربطها بـ Localhost الخاص بالماك
//   static const String fastApiBaseUrl = 'http://10.0.2.2:8000';
// }

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
   // استخدمي 10.0.2.2 لأجهزة أندرويد لربطها بـ Localhost الخاص بالماك
  static String get fastApiBaseUrl => dotenv.env['FASTAPI_BASE_URL'] ?? 'http://10.0.2.2:8000';
}