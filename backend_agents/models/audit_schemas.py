from typing import List, Optional
from pydantic import BaseModel, Field

class AuditRequest(BaseModel):
    report_id: str
    image_url: str
    activity_type: str
    facility_name: str#Optional[str] = "مطعم الشادن"  # قيمة افتراضية لتجنب قيد الـ NOT NULL
    user_id: str #Optional[str] = None

class AuditResultSchema(BaseModel):
    compliance_score: int = Field(ge=0, le=100)
    status: str  # compliant, non_compliant, under_review
    detected_violations: List[str]
    corrective_actions: List[str]

from pydantic import BaseModel
from typing import Optional

class AuditRequest(BaseModel):
    report_id: str
    image_url: str
    activity_type: str
    facility_name: Optional[str] = "مطعم الشادن"
    user_id: Optional[str] = None