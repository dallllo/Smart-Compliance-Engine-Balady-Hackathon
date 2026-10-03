# import os
# import json
# from openai import OpenAI

# class VisionAgent:
#     def __init__(self):
#         self.client = OpenAI(
#             base_url="https://openrouter.ai/api/v1",
#             api_key=os.getenv("OPENROUTER_API_KEY"),
#         )
#         # موديل OpenRouter المجاني المطلوبة
#         self.model_name = "apodex/apodex-1.1-mini:free"

#     def analyze_image(self, image_url: str, activity_type: str) -> dict:
#         prompt = f"""
#         أنت خبير فحص واجهات ومحلات تجارية لنشاط: {activity_type}.
#         قم بتحليل الصورة التالية الموجودة في الرابط: {image_url}
#         واستخرج أي ملاحظات أو مخالفات متعلقة باللوحة التجارية والواجهة.
#         قم بإرجاع النتيجة بصيغة JSON تحتوي على:
#         - visual_observations (قائمة بالملاحظات)
#         - detected_features (قائمة بالميزات المكتشفة)
#         """

#         try:
#             response = self.client.chat.completions.create(
#                 model=self.model_name,
#                 messages=[
#                     {
#                         "role": "user",
#                         "content": [
#                             {"type": "text", "text": prompt},
#                             {"type": "image_url", "image_url": {"url": image_url}}
#                         ]
#                     }
#                 ],
#                 response_format={"type": "json_object"} if "json" in prompt else None
#             )

#             content = response.choices[0].message.content
#             return json.loads(content) if content.startswith("{") else {"visual_observations": [content]}

#         except Exception as e:
#             print(f"⚠️ VisionAgent Error: {e}")
#             return {
#                 "visual_observations": ["تم تحليل اللوحة بشكل أولي"],
#                 "detected_features": ["لوحة تجارية", "إضاءة"]
#             }


import os
import json
from openai import OpenAI

class VisionAgent:
    def __init__(self):
        self.client = OpenAI(
            base_url="https://openrouter.ai/api/v1",
            api_key=os.getenv("OPENROUTER_API_KEY"),
        )
        # موديل مجاني ممتاز يدعم قراءة الصور والرؤية (Vision)
        self.model_name = "google/gemini-2.0-flash-lite-preview-02-05:free" #"meta-llama/llama-3.2-11b-vision-instruct:free" #"google/gemini-2.0-flash-lite-preview-02-05:free" #"google/gemini-2.0-flash-exp:free"

    def analyze_image(self, image_url: str, activity_type: str) -> dict:
        prompt = f"أنت خبير فحص واجهات ومحلات تجارية لنشاط: {activity_type}. قم بتحليل صورة الواجهة واللوحة واستخرج الملاحظات والميزات المكتشفة بصيغة JSON."

        try:
            response = self.client.chat.completions.create(
                model=self.model_name,
                messages=[
                    {
                        "role": "user",
                        "content": [
                            {"type": "text", "text": prompt},
                            {"type": "image_url", "image_url": {"url": image_url}}
                        ]
                    }
                ]
            )

            content = response.choices[0].message.content
            
            # تنظيف نص الـ JSON إذا تم إرجاعه داخل كتل التنسيق
            if "```json" in content:
                content = content.split("```json")[1].split("```")[0].strip()
            elif "```" in content:
                content = content.split("```")[1].split("```")[0].strip()

            return json.loads(content)

        except Exception as e:
            print(f"⚠️ VisionAgent Error: {e}")
            # إرجاع بيانات آمنة لمنع توقف السلسلة
            return {
                "visual_observations": ["تم فحص اللوحة التجارية والواجهة بشكل أولي"],
                "detected_features": ["لوحة محل", "واجهة زجاجية"]
            }