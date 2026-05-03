import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:massar_project/core/widgets/custom_text_field.dart';
import 'package:massar_project/core/widgets/primary_button.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_event.dart';

class AdditionalInfoBottomSheet extends StatefulWidget {
  const AdditionalInfoBottomSheet({super.key});

  @override
  State<AdditionalInfoBottomSheet> createState() => _AdditionalInfoBottomSheetState();
}

class _AdditionalInfoBottomSheetState extends State<AdditionalInfoBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  String _selectedGender = 'male';
  String _selectedLocation = '';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    

    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'نحتاج إلى بعض المعلومات الإضافية',
                  style: TextStyle(
                    fontFamily: 'ReadexPro',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'يرجى إكمال البيانات التالية لإنشاء حسابك',
                  style: TextStyle(
                    fontFamily: 'ReadexPro',
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 32),

                // Phone Number
                CustomTextField(
                  controller: _phoneController,
                  label: 'رقم الجوال',
                  hintText: '777 777 777',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال رقم الجوال';
                    }
                    if (value.length < 9) {
                      return 'رقم الجوال غير صحيح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Gender Selector
                Text(
                  'الجنس',
                  style: TextStyle(
                    fontFamily: 'ReadexPro',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildGenderCard(
                        label: 'ذكر',
                        value: 'male',
                        icon: Icons.male,
                        isSelected: _selectedGender == 'male',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildGenderCard(
                        label: 'أنثى',
                        value: 'female',
                        icon: Icons.female,
                        isSelected: _selectedGender == 'female',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Location Selection
                Text(
                  'الموقع',
                  style: TextStyle(
                    fontFamily: 'ReadexPro',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: AppColors.mainButton),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'يرجى تحديد موقعك',
                              style: TextStyle(
                                fontFamily: 'ReadexPro',
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () {
                          print('DEBUG: Opening map selection...');
                          setState(() => _selectedLocation = 'Sana\'a, Yemen'); // Mock selection
                        },
                        icon: const Icon(Icons.map_outlined),
                        label: const Text('فتح الخريطة'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Submit Button
                PrimaryButton(
                  label: 'إكمال التسجيل',
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context.read<AuthBloc>().add(
                            CompleteRegistrationRequested(
                              phoneNumber: _phoneController.text,
                              gender: _selectedGender,
                              location: _selectedLocation,
                            ),
                          );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderCard({
    required String label,
    required String value,
    required IconData icon,
    required bool isSelected,
  }) {
    
    

    return InkWell(
      onTap: () => setState(() => _selectedGender = value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.mainButton
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.mainButton
                : Colors.grey.shade200,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'ReadexPro',
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}






