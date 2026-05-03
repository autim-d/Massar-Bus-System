import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:massar_project/core/theme/app_colors.dart';
import 'package:massar_project/core/constants/app_strings.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_event.dart';
import 'package:massar_project/features/auth/bloc/auth_state.dart';
import 'package:massar_project/features/account/models/user_model.dart';
import 'package:image_picker/image_picker.dart'; // إضافة المكتبة
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? _lastUser;

  // دالة إظهار نافذة التعديل والربط مع الـ Bloc
  void _editField(
    BuildContext context,
    String title,
    String currentValue,
    String fieldKey,
    UserModel user,
  ) {
    // نستخدم controller واحد للنص المدخل
    TextEditingController controller = TextEditingController(
      text: currentValue,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            '${AppStrings.editPrefix} $title',
            style: TextStyle(
              fontFamily: 'Cairo',
              color: AppColors.textPrimary,
            ),
          ),
          content: TextField(
            controller: controller,
            style: TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: '${AppStrings.enterNew} $title',
              labelStyle: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                AppStrings.cancel,
                style: TextStyle(fontFamily: 'Cairo'),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                UserModel updatedUser;

                // منطق تحديث الحقول بناءً على الـ key
                if (fieldKey == 'name') {
                  String fullName = controller.text.trim();
                  List<String> names = fullName.split(' ');

                  // تحديث الاسم الأول والآخر (إذا وجد اسم آخر)
                  updatedUser = user.copyWith(
                    firstName: names.isNotEmpty ? names[0] : user.firstName,
                    lastName: names.length > 1
                        ? names.sublist(1).join(' ')
                        : '',
                  );
                } else if (fieldKey == 'phone') {
                  updatedUser = user.copyWith(
                    phoneNumber: controller.text.trim(),
                  );
                } else if (fieldKey == 'email') {
                  updatedUser = user.copyWith(email: controller.text.trim());
                } else {
                  updatedUser = user;
                }

                // إرسال الحدث إلى AuthBloc (الذي تم تجهيزه مسبقاً)
                context.read<AuthBloc>().add(
                  UpdateProfileSubmitted(user: updatedUser),
                );

                Navigator.pop(context);
              },
              child: const Text(
                AppStrings.save,
                style: TextStyle(fontFamily: 'Cairo', color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRow(
    BuildContext context,
    String title,
    String value,
    VoidCallback onEdit,
  ) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Cairo',
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onEdit,
            child: const Text(
              AppStrings.edit,
              style: TextStyle(
                color: AppColors.textEdit,
                fontSize: 14,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تحديث البيانات بنجاح', style: TextStyle(fontFamily: 'Cairo')),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message, style: TextStyle(fontFamily: 'Cairo')),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          _lastUser = state.user;
        } else if (state is ProfileUpdateSuccess) {
          _lastUser = state.user;
        }
        
        // إذا لم يكن هناك بيانات نهائياً (مثلاً في بداية التشغيل)
        if (_lastUser == null && state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (_lastUser == null) {
          return const Scaffold(
            body: Center(child: Text('يرجى تسجيل الدخول لعرض الملف الشخصي', style: TextStyle(fontFamily: 'Cairo'))),
          );
        }
        
        final currentUser = _lastUser!; 

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                AppStrings.myAccount,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontFamily: 'Cairo',
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // قسم الصورة الشخصية
                  _buildPhotoSection(context, currentUser),
                  const SizedBox(height: 10),
                  Divider(thickness: 1, color: AppColors.grey200),

                  // عرض الاسم الكامل
                  _buildRow(
                    context,
                    AppStrings.nameLabel,
                    '${currentUser.firstName} ${currentUser.lastName}'.trim(),
                    () {
                      _editField(
                        context,
                        AppStrings.nameLabel,
                        '${currentUser.firstName} ${currentUser.lastName}'.trim(),
                        'name',
                        currentUser,
                      );
                    },
                  ),
                  _buildDivider(),

                  // عرض البريد
                  _buildRow(context, AppStrings.emailLabel, currentUser.email, () {
                    _editField(
                      context,
                      AppStrings.emailLabel,
                      currentUser.email,
                      'email',
                      currentUser,
                    );
                  }),
                  _buildDivider(),

                  // عرض رقم الهاتف
                  _buildRow(
                    context,
                    AppStrings.phoneLabel,
                    currentUser.phoneNumber,
                    () {
                      _editField(
                        context,
                        AppStrings.phoneLabel,
                        currentUser.phoneNumber,
                        'phone',
                        currentUser,
                      );
                    },
                  ),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhotoSection(
    BuildContext context,
    UserModel user,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                  if (image != null && context.mounted) {
                    context.push('/account/edit-photo', extra: image.path);
                  }
                },
                borderRadius: BorderRadius.circular(40),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.grey200.withOpacity(0.2),
                  backgroundImage: user.profileImage.isNotEmpty
                      ? (user.profileImage.startsWith('http')
                          ? NetworkImage(user.profileImage)
                          : (user.profileImage.startsWith('assets')
                              ? AssetImage(user.profileImage)
                              : FileImage(File(user.profileImage)) as ImageProvider))
                      : null,
                  child: user.profileImage.isEmpty
                      ? Icon(Icons.person, size: 40, color: AppColors.grey200)
                      : null,
                ),
              ),
              const SizedBox(width: 15),
              Text(
                AppStrings.myPhoto,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              // الضغط على تعديل يفتح شاشة الضبط للصورة الحالية
              context.push('/account/edit-photo', extra: user.profileImage);
            },
            child: const Text(
              AppStrings.edit,
              style: TextStyle(
                color: AppColors.textEdit,
                fontSize: 16,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Divider(height: 1, color: AppColors.grey200.withOpacity(0.4)),
  );
}







