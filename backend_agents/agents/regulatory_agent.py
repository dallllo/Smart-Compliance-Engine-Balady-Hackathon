import os
import json
from openai import OpenAI

class RegulatoryAgent:
    def __init__(self):
        self.client = OpenAI(
            base_url="https://openrouter.ai/api/v1",
            api_key=os.getenv("OPENROUTER_API_KEY"),
        )
        self.model_name = "apodex/apodex-1.1-mini:free"

    def match_regulations(self, visual_data: dict, activity_type: str) -> dict:
        """
        مطابقة الملاحظات البصرية المكتشفة مع اللوائح والاشتراطات البلدية
        """
        prompt = f"""
        أنت مستشار تنظيم بلدي متخصص.
        النشاط التجارية: {activity_type}
        الملاحظات البصرية المكتشفة: {json.dumps(visual_data, ensure_ascii=False)}

        قم بمقارنة هذه الملاحظات مع الاشتراطات البلدية العامة ورصد أي مخالفات تنظيمية.
        قم بتقديم المخرجات بصيغة JSON فقط تحتوي على:
        {{
            "activity_type": "{activity_type}",
            "matched_regulations": ["قائمة بالاشتراطات المطبقة"],
            "potential_violations": ["قائمة بالمخالفات المحتملة بناءً على الملاحظات البصرية"]
        }}
        """

        try:
            response = self.client.chat.completions.create(
                model=self.model_name,
                messages=[
                    {"role": "system", "content": "أنت مساعد متخصص في تحليل اللوائح والاشتراطات البلدية وإرجاع النتائج بصيغة JSON فقط."},
                    {"role": "user", "content": prompt}
                ]
            )

            content = response.choices[0].message.content

            # تنظيف النتيجة من زوائد Markdown إذا وجدت
            if "```json" in content:
                content = content.split("```json")[1].split("```")[0].strip()
            elif "```" in content:
                content = content.split("```")[1].split("```")[0].strip()

            return json.loads(content)

        except Exception as e:
            print(f"⚠️ RegulatoryAgent Error: {e}")
            # بيانات Fallback آمنة في حال حدوث أي خطأ في الاتصال
            return {
                "activity_type": activity_type,
                "matched_regulations": ["اشتراطات اللوحات التجارية والواجهات"],
                "potential_violations": ["تحتاج اللوحة للتحقق من مطابقة الأبعاد والارتفاع"]
            }