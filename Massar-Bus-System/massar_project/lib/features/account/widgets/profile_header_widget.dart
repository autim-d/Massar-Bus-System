import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:massar_project/core/theme/app_colors.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_event.dart';

class ProfileHeaderWidget extends StatefulWidget {
  // استقبال البيانات الحقيقية من الباك أند
  final String? name;
  final String? email;
  final String? imageUrl;

  const ProfileHeaderWidget({super.key, this.name, this.email, this.imageUrl});

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  File? _localImage;

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _localImage = File(pickedFile.path);
      });
      if (mounted) {
        context.read<AuthBloc>().add(
          UpdateAvatarRequested(imagePath: pickedFile.path),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    

    ImageProvider imageProvider;
    if (_localImage != null) {
      imageProvider = FileImage(_localImage!);
    } else if (widget.imageUrl != null &&
        widget.imageUrl!.isNotEmpty &&
        widget.imageUrl!.startsWith('http')) {
      imageProvider = NetworkImage(widget.imageUrl!);
    } else {
      imageProvider = const AssetImage('assets/images/defulte.jpg');
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: _pickAndUploadImage,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: 30,
                  backgroundColor: Colors.grey.shade200,
                ),
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // عرض الاسم القادم من الباك أند
                  widget.name ?? 'مستخدم مسار',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  // عرض البريد القادم من الباك أند
                  widget.email ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



