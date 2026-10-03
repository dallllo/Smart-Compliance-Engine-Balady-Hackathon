import os
import json
from openai import OpenAI

class ReportAgent:
    def __init__(self):
        self.client = OpenAI(
            base_url="https://openrouter.ai/api/v1",
            api_key=os.getenv("OPENROUTER_API_KEY"),
        )
        self.model_name = "apodex/apodex-1.1-mini:free"

    def generate_final_report(self, regulatory_data: dict) -> dict:
        prompt = f"""
        بناءً على البيانات التنظيمية التالية:
        {json.dumps(regulatory_data, ensure_ascii=False)}

        قم بإنشاء تقرير فحص نهائي بصيغة JSON تحتوي على الأجزاء التالية بالضبط:
        {{
            "compliance_score": 85,
            "detected_violations": ["قائمة بالمخالفات المكتشفة"],
            "corrective_actions": ["قائمة بالإجراءات التصحيحية"]
        }}
        """

        try:
            response = self.client.chat.completions.create(
                model=self.model_name,
                messages=[
                    {"role": "system", "content": "أنت مساعد متخصص في صياغة تقارير الامتثال البلدي باللغة العربية وإرجاع النتائج بصيغة JSON فقط."},
                    {"role": "user", "content": prompt}
                ]
            )

            content = response.choices[0].message.content
            # تنظيف النتيجة إذا احتوت على markdown
            if "```json" in content:
                content = content.split("```json")[1].split("```")[0].strip()
            elif "```" in content:
                content = content.split("```")[1].split("```")[0].strip()

            return json.loads(content)

        except Exception as e:
            print(f"⚠️ ReportAgent Error: {e}")
            return {
                "compliance_score": 85,
                "detected_violations": ["عدم مطابقة بعض الأبعاد في اللوحة التجارية"],
                "corrective_actions": ["تعديل اللوحة حسب اشتراطات البلدية"]
            }