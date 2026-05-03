import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/core/theme/app_colors.dart';
import 'package:massar_project/core/constants/app_strings.dart';
import 'package:massar_project/core/constants/dummy_data.dart';
import 'package:massar_project/features/account/controllers/profile_controller.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _editField(BuildContext context, WidgetRef ref, String title, String currentValue, String fieldKey) {
    TextEditingController controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('${AppStrings.editPrefix} $title'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: '${AppStrings.enterNew} $title ${AppStrings.newValue}',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text(AppStrings.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(profileControllerProvider.notifier).updateField(fieldKey, controller.text);
                context.pop();
              },
              child: const Text(AppStrings.save),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRow(BuildContext context, String title, String value, VoidCallback onEdit) {
    final theme = Theme.of(context);
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: theme.textTheme.titleLarge?.color),
                ),
                const SizedBox(height: 4),
                Text(value, style: TextStyle(fontSize: 15, color: theme.textTheme.bodyLarge?.color)),
              ],
            ),
          ),
          TextButton(
            onPressed: onEdit,
            child: const Text(AppStrings.edit, style: TextStyle(color: AppColors.textEdit)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the profile state
    final profileState = ref.watch(profileControllerProvider);
    final profileNotifier = ref.read(profileControllerProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myAccount),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        iconTheme: theme.iconTheme,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Divider(height: 1, color: theme.dividerColor),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Column(
                      children: [
                        Text(
                          AppStrings.myPhoto,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: profileState.image != null
                              ? FileImage(profileState.image!) as ImageProvider
                              : (profileState.avatarUrl != null && profileState.avatarUrl!.startsWith('http')
                                  ? NetworkImage(profileState.avatarUrl!) as ImageProvider
                                  : const AssetImage(DummyData.userAvatarPath)),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => profileNotifier.pickImage(),
                    child: const Text(
                      AppStrings.edit,
                      style: TextStyle(fontSize: 16, color: AppColors.textEdit),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Divider(thickness: 1, color: theme.dividerColor),
            const SizedBox(height: 7),

            _buildRow(context, AppStrings.nameLabel, profileState.name, () {
              _editField(context, ref, AppStrings.nameLabel, profileState.name, 'name');
            }),
            SizedBox(
              width: 335,
              child: Divider(height: 4, color: theme.dividerColor.withValues(alpha: 0.4)),
            ),
            const SizedBox(height: 7),

            _buildRow(context, AppStrings.emailLabel, profileState.email, () {
              _editField(context, ref, AppStrings.emailLabel, profileState.email, 'email');
            }),
            SizedBox(
              width: 335,
              child: Divider(height: 4, color: theme.dividerColor.withValues(alpha: 0.4)),
            ),
            const SizedBox(height: 7),

            _buildRow(context, AppStrings.genderLabel, profileState.gender, () {
              _editField(context, ref, AppStrings.genderLabel, profileState.gender, 'gender');
            }),
            SizedBox(
              width: 335,
              child: Divider(thickness: 1, height: 4, color: theme.dividerColor.withValues(alpha: 0.4)),
            ),
            const SizedBox(height: 7),

            _buildRow(context, AppStrings.phoneLabel, profileState.phone, () {
              _editField(context, ref, AppStrings.phoneLabel, profileState.phone, 'phone');
            }),
          ],
        ),
      ),
    );
  }
}
