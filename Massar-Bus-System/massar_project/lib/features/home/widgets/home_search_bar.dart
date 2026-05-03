import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart'; // تأكد من إضافة مكتبة lucide_icons

class HomeSearchBar extends StatelessWidget {
  final VoidCallback? onTap;

  const HomeSearchBar({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: const Color(0xFFE4E7EC),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          // تم إضافة Row لتنظيم الأيقونات مع النص ليعطي مظهر "شريط بحث" حقيقي
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // أيقونة البحث في الجهة اليمنى (بداية الصف في RTL)
              Row(
                children: [
                  Icon(
                    LucideIcons.search,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'أين تريد الذهاب اليوم؟',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textSecondary?.withOpacity(
                        0.7,
                      ),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'ReadexPro', // استخدام خط المشروع المعتمد
                    ),
                  ),
                ],
              ),
              // أيقونة الفلترة الاختيارية في الطرف الآخر لإعطاء لمسة جمالية
              Icon(
                LucideIcons.slidersHorizontal,
                size: 18,
                color: AppColors.mainButton.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




