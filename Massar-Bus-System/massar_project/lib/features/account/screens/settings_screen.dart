import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../widgets/settings_list_tile.dart';
import '../widgets/settings_section_header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'الإعدادات',
            style: TextStyle(
              color: theme.textTheme.titleLarge?.color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'ReadexPro',
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, color: theme.iconTheme.color),
            onPressed: () => Navigator.of(context).pop(),
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
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
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
                    Divider(color: theme.dividerColor, height: 1, indent: 70),
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
              
              const SizedBox(height: 24),
              
              // Preferences Section
              const SettingsSectionHeader(title: 'التفضيلات'),
              Container(
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SettingsListTile(
                      title: 'المظهر',
                      subtitle: 'تخصيص ألوان التطبيق',
                      leadingIcon: LucideIcons.palette,
                      onTap: () {
                        context.push('/account/settings/appearance');
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
