import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../cubit/audit_cubit.dart';
import '../cubit/audit_state.dart';
import 'dart:io';

class NewAuditPage extends HookWidget {
  const NewAuditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final facilityNameController = useTextEditingController();
    final activityTypeController = useTextEditingController(text: 'مطعم');
    final selectedImage = useState<XFile?>(null);
    final picker = useMemoized(() => ImagePicker());

    final primaryColor = Theme.of(context).colorScheme.primary;

    Future<void> pickImage(ImageSource source) async {
      final image = await picker.pickImage(
        source: source,
        imageQuality: 70,
      );
      if (image != null) {
        selectedImage.value = image;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('فحص منشأة جديدة'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _showImageSourceDialog(context, pickImage),
              child: Container(
                height: 190,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: selectedImage.value != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          File(selectedImage.value!.path),
                          fit: BoxFit.cover,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo_outlined,
                            size: 48,
                            color: primaryColor,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'اضغط لالتقاط صورة المنشأة أو اختيارها',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: facilityNameController,
              decoration: InputDecoration(
                labelText: 'اسم المنشأة / المحل',
                prefixIcon: Icon(Icons.storefront_outlined, color: primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: activityTypeController,
              decoration: InputDecoration(
                labelText: 'نوع النشاط',
                prefixIcon: Icon(Icons.category_outlined, color: primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 28),
            BlocConsumer<AuditCubit, AuditState>(
              listener: (context, state) {
                if (state is AuditSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم الفحص وإصدار التقرير بنجاح!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                } else if (state is AuditErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('خطأ: ${state.message}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuditLoadingState) {
                  return const CircularProgressIndicator();
                }

                return ElevatedButton.icon(
                  onPressed: () {
                    if (facilityNameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('يرجى إدخال اسم المنشأة')),
                      );
                      return;
                    }

                    final newReportId = const Uuid().v4();

                    final imagePath = selectedImage.value?.path ??
                        'https://images.unsplash.com/photo-1555396273-367ea4eb4db5';

                    context.read<AuditCubit>().runAudit(
                          reportId: newReportId,
                          imageUrl: imagePath,
                          activityType: activityTypeController.text,
                          facilityName: facilityNameController.text,
                        );
                  },
                  icon: const Icon(Icons.analytics_outlined),
                  label: const Text('بدء التقييم والمسح الذكي'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceDialog(
      BuildContext context, Function(ImageSource) onSelect) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: primaryColor),
              title: const Text('التقاط صورة بالكاميرا'),
              onTap: () {
                Navigator.pop(context);
                onSelect(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: primaryColor),
              title: const Text('اختيار صورة من المعرض'),
              onTap: () {
                Navigator.pop(context);
                onSelect(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
