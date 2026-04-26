import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String firstName = "عدنان";
  String lastName = "البيتي";
  String phoneNumber = "+967 774 393 235";
  String profileImage = 'assets/images/adnan.jpg';

  bool noLastName = false;
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  //-------------------------------------------------
  void _openEditPhotoPage() async {
    final newImage = await context.push('/account/edit-photo', extra: profileImage);

    if (newImage != null && newImage is String) {
      setState(() {
        profileImage = newImage;
      });
    }
  }

  //-------------------------------------------------
  //-------------------------------------------------
  void _openEditNameSheet() {
    _firstController.text = firstName;
    _lastController.text = lastName;
    noLastName = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardTheme.color,
      // ignore: deprecated_member_use
      barrierColor: Colors.black.withOpacity(0.4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final theme = Theme.of(context);
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
                            color: theme.textTheme.titleLarge?.color,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: theme.iconTheme.color),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text('الاسم الأول', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _firstController,
                      style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.inputDecorationTheme.fillColor ?? theme.cardTheme.color,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: theme.dividerColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('الاسم الأخير', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _lastController,
                      enabled: !noLastName,
                      style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.inputDecorationTheme.fillColor ?? theme.cardTheme.color,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: theme.dividerColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 1, 105, 190),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: noLastName,
                          activeColor: Colors.blue,
                          onChanged: (value) {
                            setModalState(() {
                              noLastName = value ?? false;
                              if (noLastName) _lastController.clear();
                            });
                          },
                        ),
                        Text('ليس لدي اسم أخير', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                      ],
                    ),
                    const SizedBox(height: 8),
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
                          setState(() {
                            firstName = _firstController.text.trim();
                            lastName =
                                noLastName ? '' : _lastController.text.trim();
                          });
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

  //-------------------------------------------------
  void _openEditPhoneSheet() {
    _phoneController.text = phoneNumber;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardTheme.color,
      // ignore: deprecated_member_use
      barrierColor: Colors.black.withOpacity(0.4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final theme = Theme.of(context);
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
                        IconButton(
                          icon: Icon(Icons.close, color: theme.iconTheme.color),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          'رقمك',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.titleLarge?.color,
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text('تعديل رقم الجوال', style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                    TextField(
                      controller: _phoneController,
                      style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.inputDecorationTheme.fillColor ?? theme.cardTheme.color,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: theme.dividerColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
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
                          setState(() {
                            phoneNumber = _phoneController.text.trim();
                          });
                          Navigator.pop(context);
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

  //-------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            'حسابي',
            style: TextStyle(color: theme.textTheme.titleLarge?.color, fontWeight: FontWeight.bold),
          ),
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
            onPressed: () => context.pop(),
          ),
          titleSpacing: -10,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 1, color: theme.dividerColor),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'صورتي',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: theme.textTheme.bodyLarge?.color),
                  ),
                  TextButton(
                    onPressed: _openEditPhotoPage,
                    child: const Text(
                      'تعديل',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: profileImage.startsWith('assets')
                      ? AssetImage(profileImage) as ImageProvider
                      : FileImage(File(profileImage)),
                ),
              ),
              const SizedBox(height: 12),
              Container(height: 1, color: theme.dividerColor),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'اسمك',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: theme.textTheme.bodyLarge?.color),
                  ),
                  TextButton(
                    onPressed: _openEditNameSheet,
                    child: const Text(
                      'تعديل',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Text(
                lastName.isEmpty ? firstName : '$firstName $lastName',
                style: TextStyle(fontSize: 16, color: theme.textTheme.bodyLarge?.color),
              ),
              const SizedBox(height: 8),
              Container(height: 1, color: theme.dividerColor),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'رقم الجوال',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: theme.textTheme.bodyLarge?.color),
                  ),
                  TextButton(
                    onPressed: _openEditPhoneSheet,
                    child: const Text(
                      'تعديل',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Text(
                phoneNumber,
                style: TextStyle(fontSize: 16, color: theme.textTheme.bodyLarge?.color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
