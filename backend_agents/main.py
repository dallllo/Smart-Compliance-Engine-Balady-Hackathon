from fastapi import FastAPI, HTTPException, BackgroundTasks
from pydantic import BaseModel
# import uuid
from core.supabase_client import supabase
from services.audit_service import AuditService

app = FastAPI()
audit_service = AuditService()

class AuditRequest(BaseModel):
    report_id: str
    user_id: str
    facility_name: str
    activity_type: str
    image_url: str

# @app.post("/api/v1/analyze-audit")
# async def analyze_audit(request: AuditRequest, background_tasks: BackgroundTasks):
#     # 1. إنشاء السجل المبدئي بحالة under_review فوراً في Supabase
#     try:
#         supabase.table("audit_reports").insert({
#             "id": request.report_id,
#             "user_id": request.user_id,
#             "facility_name": request.facility_name,
#             "activity_type": request.activity_type,
#             "image_url": request.image_url,
#             "compliance_score": 0,
#             "status": "under_review",
#             "detected_violations": [],
#             "corrective_actions": []
#         }).execute()
#     except Exception as e:
#         print(f"⚠️ Initial Record Creation Warning: {e}")

#     # 2. إطلاق المعالجة في الخلفية لتحديث البيانات لاحقاً
#     background_tasks.add_task(
#         audit_service.run_full_audit,
#         report_id=request.report_id,
#         image_url=request.image_url,
#         activity_type=request.activity_type
#     )

#     return {"status": "processing", "report_id": request.report_id}


@app.post("/api/v1/analyze-audit")
async def analyze_audit(request: AuditRequest, background_tasks: BackgroundTasks):
    # 1. إنشاء السجل المبدئي بحالة under_review فوراً في Supabase
    try:
        supabase.table("audit_reports").insert({
            "id": request.report_id,
            "user_id": request.user_id,
            "facility_name": request.facility_name,
            "activity_type": request.activity_type,
            "image_url": request.image_url,
            "compliance_score": 0,
            "status": "under_review",
            "detected_violations": [],
            "corrective_actions": []
        }).execute()
    except Exception as e:
        print(f"⚠️ Initial Record Creation Warning: {e}")

    # 2. إطلاق المعالجة في الخلفية لتحديث البيانات لاحقاً
    background_tasks.add_task(
        audit_service.run_full_audit,
        report_id=request.report_id,
        image_url=request.image_url,
        activity_type=request.activity_type
    )

    return {"status": "processing", "report_id": request.report_id}