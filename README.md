# 🛡️ منصة مُمْتَثِل الذكي | Smart Compliance Engine

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)
![Python](https://img.shields.io/badge/Python-3.x-3776AB?logo=python)
![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-009688?logo=fastapi)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-1E5631)
![State%20Management](https://img.shields.io/badge/State%20Management-Flutter%20Cubit-D4AF37)
![Backend](https://img.shields.io/badge/Backend-Supabase%20%26%20Multi--Agent%20FastAPI-green)

نظام ذكي وشامل لتقييم ومراقبة امتثال المنشآت والمحلات التجارية للاشتراطات البلدية، يعتمد على تقنيات الذكاء الاصطناعي المتعددة (Multi-Agent AI System) ومعالجة الصور المتقدمة لتقديم تقارير امتثال فورية، دقيقة، وموثوقة.

---

## 🌟 أبرز المميزات (Key Features)

- 📸 **مسح وفحص ذكي للمنشآت:** التقاط أو اختيار صور المنشأة وتحليلها تلقائياً عبر وكلاء الذكاء الاصطناعي.
- 📊 **مؤشر نسبة الامتثال الفوري:** حساب وتقييم نسبة الامتثال العامة لكل منشأة مع عرض التقرير بحالات متغيرة (مكتمل، قيد التقييم).
- ⚠️ **رصد الانتهاكات والمخالفات:** استخراج قائمة دقيقة بالمخالفات والاشتراطات غير الممتثل لها عبر `regulatory_agent` و `vision_agent`.
- 🛠️ **توصيات وإجراءات تصحيحية:** تقديم حلول وإجراءات فورية لمساعدة أصحاب المنشآت على رفع مستوى الامتثال.
- ⚡ **دعم Offline-First:** تخزين مؤقت للبيانات المحلية باستخدام **Hive** لتوفير تجربة استخدام سريعة ومستمرة حتى بدون اتصال بالشبكة.
- 🎨 **هوية بصرية معتمدة:** واجهات UI/UX حديثة مصممة بألوان الهوية المعتمدة (الأخضر البلدي والذهبي) وباستخدام خط **Cairo**.

---

## 🏗️ الهيكلية البرمجية (System Architecture)

يعتمد المشروع على هندسة برمجية متكاملة تفصل بين الواجهات الأمامية والأنظمة الخلفية الذكية:

### 1️⃣ الواجهة الأمامية (Frontend App)
تم بناء التطبيق باتباع **مبادئ الهندسة النظيفة (Clean Architecture)** مع تطبيق **Flutter Cubit** لإدارة حالة التطبيق:


```text
frountend_app/
├── lib/
│   ├── core/
│   │   ├── constants/       # AppConstants & Configurations
│   │   ├── theme/           # AppTheme (Balady Green & Gold)
│   │   └── di/              # Service Locator (GetIt)
│   └── features/
│       └── audit/
│           ├── data/        # Models, Data Sources & Repositories
│           ├── domain/      # Entities, Repositories & Use Cases
│           └── presentation/# Cubit (AuditCubit & AuditState), Pages & Widgets

```

###  الأنظمة الخلفية والذكاء الاصطناعي (Backend Multi-Agent Architecture)

تم تصميم الباكند باستخدام **FastAPI** وتوزيع مهام التحليل الذكي على **وكلاء ذكاء اصطناعي (Multi-Agents)** متعددي التخصصات لضمان الدقة والسرعة:

```text
backend_agents/
├── agents/
│   ├── vision_agent.py      # وكيل الرؤية الحاسوبية ومعالجة الصور
│   ├── regulatory_agent.py  # وكيل التحقق من الاشتراطات واللوائح البلدية
│   └── report_agent.py      # وكيل صياغة وإصدار تقارير الامتثال
├── core/
│   ├── config.py            # إعدادات النظام وتكوينات البيئة
│   └── supabase_client.py   # ربط وإدارة عمليات قاعدة البيانات Supabase
├── models/
│   └── audit_schemas.py     # نماذج وهياكل البيانات (Pydantic Schemas)
├── services/
│   └── audit_service.py     # منطق معالجة عمليات الفحص المترابطة
└── main.py                  # نقطة انطلاق سيرفر FastAPI والـ Endpoints

```

---

## 🛠️ التقنيات المستخدمة (Tech Stack)

* **Frontend:** Flutter (Dart) - Material 3 - Google Fonts (Cairo)
* **State Management:** Flutter Cubit
* **Dependency Injection:** GetIt
* **Local Storage:** Hive
* **Backend Framework:** FastAPI (Python 3.x)
* **AI Architecture:** Multi-Agent System (Vision Agent, Regulatory Agent, Report Agent)
* **Database & Storage:** Supabase (PostgreSQL & Object Storage)
* **Security:** `flutter_dotenv` & Environment Variables

---
:
## 📱 لقطات من التطبيق (Screenshots) 


<img width="1280" height="565" alt="5911058963325718502" src="https://github.com/user-attachments/assets/5b078200-d9fa-47ff-8284-7539f178a943" />

https://github.com/user-attachments/assets/518c8d70-d34e-48e8-a0d1-de150ddd320e

https://github.com/user-attachments/assets/c887b32d-c09d-4eee-ba3e-d550cd7b4c8a
## 🚀 كيفية التشغيل والتهيئة (Getting Started)

### 1️⃣ الاستنساخ (Clone the Repository)

```bash
git clone https://github.com/dallllo/Smart-Compliance-Engine-Balady-Hackathon.git
cd smart-compliance-engine

```

### 2️⃣ تهيئة وتشغيل الباكند (Backend Agents)

```bash
cd backend_agents
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --reload

```

### 3️⃣ تهيئة وتشغيل التطبيق (Frontend App)

أنشئ ملف `.env` داخل `frountend_app` وأضف الإعدادات التالية:

```env
SUPABASE_URL=[https://your-supabase-url.supabase.co](https://your-supabase-url.supabase.co)
SUPABASE_ANON_KEY=your-supabase-anon-key
FASTAPI_BASE_URL=[http://10.0.2.2:8000](http://10.0.2.2:8000)

```

ثم قم بتشغيل التطبيق:

```bash
cd frountend_app
flutter pub get
flutter run

```

---

## 👩‍💻 التطوير والبرمجة (Developer)

تم تطوير وصياغة هذا المشروع بواسطة:

* **المطوّرة:** دلال فالح 

---

## 📄 الترخيص (License)

هذا المشروع مخصص لمشاركة وتطوير حلول الامتثال البلدي الذكي ضمن **هاكاثون بلدي (Balady Hackathon)**.
