import 'package:massar_project/core/theme/app_colors.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // إضافة الاستيراد
import 'package:massar_project/features/account/models/user_model.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_event.dart';
import 'package:massar_project/features/auth/bloc/auth_state.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool noLastName = false;

  @override
  void dispose() {
    _firstController.dispose();
    _lastController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // دالة مساعدة لإرسال التحديث للسيرفر
  void _updateUserData(UserModel user) {
    context.read<AuthBloc>().add(UpdateProfileSubmitted(user: user));
  }

  void _openEditPhotoPage(String currentImage) async {
    // نرسل المستخدم لصفحة تعديل الصورة التي ربطناها بالباك أند سابقاً
    context.push('/account/edit-photo', extra: currentImage);
  }

  void _openEditNameSheet(UserModel user) {
    _firstController.text = user.firstName;
    _lastController.text = user.lastName;
    noLastName = user.lastName.isEmpty;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 40),
                        Text(
                          'اسمك',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: AppColors.textPrimary),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'الاسم الأول',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _firstController,
                      style: TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'الاسم الأخير',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _lastController,
                      enabled: !noLastName,
                      style: TextStyle(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: noLastName,
                          activeColor: Colors.blue,
                          onChanged: (value) =>
                              setModalState(() => noLastName = value ?? false),
                        ),
                        Text(
                          'ليس لدي اسم أخير',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // إرسال التحديث للسيرفر عبر الـ Bloc
                          final updatedUser = user.copyWith(
                            firstName: _firstController.text.trim(),
                            lastName: noLastName
                                ? ''
                                : _lastController.text.trim(),
                          );
                          _updateUserData(updatedUser);
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'حفظ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _openEditPhoneSheet(UserModel user) {
    _phoneController.text = user.phoneNumber;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تعديل رقم الجوال',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    final updatedUser = user.copyWith(
                      phoneNumber: _phoneController.text.trim(),
                    );
                    _updateUserData(updatedUser);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'حفظ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // إذا لم يكن المستخدم مسجلاً، نخرج أو نظهر واجهة فارغة
        if (state is! AuthAuthenticated)
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );

        final user = state.user!; // بيانات المستخدم الحقيقية من السيرفر

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'حسابي',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
                onPressed: () => context.pop(),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    'صورتي',
                    () => _openEditPhotoPage(user.profileImage),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: user.profileImage.startsWith('http')
                          ? NetworkImage(user.profileImage) as ImageProvider
                          : (user.profileImage.startsWith('assets')
                                ? AssetImage(user.profileImage)
                                : FileImage(File(user.profileImage))
                                      as ImageProvider),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSectionHeader(
                    'اسمك',
                    () => _openEditNameSheet(user),
                  ),
                  Text(
                    '${user.firstName} ${user.lastName}'.trim(),
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSectionHeader(
                    'رقم الجوال',
                    () => _openEditPhoneSheet(user),
                  ),
                  Text(
                    user.phoneNumber,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(
    String title,
    VoidCallback onEdit,
  ) {
    return Column(
      children: [
        Container(height: 1, color: AppColors.grey200),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: onEdit,
              child: const Text(
                'تعديل',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}









