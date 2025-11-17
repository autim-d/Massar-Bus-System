import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:massar_project/app_colors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;
  final picker = ImagePicker();

  String name = "خليل ابراهيم سيلان";
  String email = "khalil@example.com";
  String gender = "ذكر";
  String phone = "+967 776463185";

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _editField(String title, String currentValue, Function(String) onSave) {
    TextEditingController controller = TextEditingController(
      text: currentValue,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('تعديل $title'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'أدخل $title الجديد',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.pop(context);
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRow(String title, String value, VoidCallback onEdit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onEdit,
            child: const Text(
              "تعديل",
              style: TextStyle(color: AppColors.textEdit),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(" حسابي ")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const SizedBox(child: Divider(height: 1)),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _pickImage();
                    },
                    child: const Text(
                      "تعديل",
                      style: TextStyle(fontSize: 16, color: AppColors.textEdit),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Column(
                      children: [
                        const Text(
                          "صورتي",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: _image != null
                              ? FileImage(_image!) as ImageProvider
                              : const AssetImage('assets/defulte.jpg'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            const Divider(thickness: 1),
            SizedBox(height: 7),

            _buildRow("الاسم", name, () {
              _editField("الاسم", name, (newValue) {
                setState(() {
                  name = newValue;
                });
              });
            }),
            SizedBox(
              width: 335,
              child: Divider(
                height: 4,
                color: const Color.fromARGB(94, 102, 112, 133),
              ),
            ),
            SizedBox(height: 7),

            _buildRow("البريد الإلكتروني", email, () {
              _editField("البريد الإلكتروني", email, (newValue) {
                setState(() {
                  email = newValue;
                });
              });
            }),
            SizedBox(
              width: 335,
              child: Divider(
                height: 4,
                color: const Color.fromARGB(94, 102, 112, 133),
              ),
            ),
            SizedBox(height: 7),

            _buildRow("الجنس", gender, () {
              _editField("الجنس", gender, (newValue) {
                setState(() {
                  gender = newValue;
                });
              });
            }),
            SizedBox(
              width: 335,
              child: Divider(
                thickness: 1,
                height: 4,
                color: const Color.fromARGB(94, 102, 112, 133),
              ),
            ),
            SizedBox(height: 7),
            _buildRow("رقم الجوال", phone, () {
              _editField("رقم الجوال", phone, (newValue) {
                setState(() {
                  phone = newValue;
                });
              });
            }),
          ],
        ),
      ),
    );
  }
}
