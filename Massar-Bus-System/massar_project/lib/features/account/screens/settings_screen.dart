import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../widgets/settings_list_tile.dart';
import '../widgets/settings_section_header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'الإعدادات',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'ReadexPro',
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
            onPressed: () => context.pop(),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Account Settings Section
              const SettingsSectionHeader(title: 'إعدادات الحساب'),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SettingsListTile(
                      title: 'الحساب',
                      subtitle: 'تعديل بياناتك الشخصية',
                      leadingIcon: LucideIcons.user,
                      onTap: () {
                        context.push('/account/profile');
                      },
                    ),
                    Divider(color: AppColors.grey200, height: 1, indent: 70),
                    SettingsListTile(
                      title: 'تغيير كلمة المرور',
                      subtitle: 'تحديث كلمة المرور الخاصة بك',
                      leadingIcon: LucideIcons.lock,
                      onTap: () {
                        context.push('/account/settings/password');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
