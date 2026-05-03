import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_event.dart';
import 'package:massar_project/features/auth/bloc/auth_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class EditPhotoScreen extends StatefulWidget {
  final String currentImage;

  const EditPhotoScreen({super.key, required this.currentImage});

  @override
  State<EditPhotoScreen> createState() => _EditPhotoScreenState();
}

class _EditPhotoScreenState extends State<EditPhotoScreen> {
  late String imagePath;
  late bool isAsset;
  late bool isNetwork;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _resetImage(widget.currentImage);
  }

  void _resetImage(String path) {
    imagePath = path;
    isAsset = imagePath.startsWith('assets/');
    isNetwork = imagePath.startsWith('http');
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
        isAsset = false;
        isNetwork = false;
      });
      _cropImage();
    }
  }

  Future<File> _prepareFileForCropping() async {
    if (isAsset) {
      final byteData = await rootBundle.load(imagePath);
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/${imagePath.split('/').last}');
      await tempFile.writeAsBytes(byteData.buffer.asUint8List());
      return tempFile;
    } else if (isNetwork) {
      final response = await http.get(Uri.parse(imagePath));
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp_avatar.jpg');
      await tempFile.writeAsBytes(response.bodyBytes);
      return tempFile;
    } else {
      return File(imagePath);
    }
  }

  Future<void> _cropImage() async {
    try {
      final file = await _prepareFileForCropping();
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'تعديل الصورة',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'تعديل الصورة',
            aspectRatioLockEnabled: true,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          imagePath = croppedFile.path;
          isAsset = false;
          isNetwork = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في معالجة الصورة: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم تحديث الصورة بنجاح'), backgroundColor: Colors.green),
            );
            context.pop();
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text('ضبط صورتك', style: TextStyle(color: Colors.black, fontFamily: 'Cairo')),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: isLoading ? null : () => context.pop(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.photo_library, color: Colors.blue),
                  onPressed: isLoading ? null : _pickImage,
                  tooltip: 'اختيار صورة جديدة',
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 280,
                          height: 280,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[900],
                            border: Border.all(color: Colors.white24, width: 2),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: isAsset
                              ? Image.asset(imagePath, fit: BoxFit.cover)
                              : isNetwork
                                  ? Image.network(
                                      imagePath,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 50, color: Colors.red),
                                    )
                                  : Image.file(File(imagePath), fit: BoxFit.cover),
                        ),
                        if (!isLoading)
                          Positioned(
                            bottom: 12,
                            right: 12,
                            child: FloatingActionButton.small(
                              onPressed: _cropImage,
                              child: const Icon(Icons.crop),
                            ),
                          ),
                        if (isLoading)
                          Container(
                            width: 280,
                            height: 280,
                            color: Colors.black54,
                            child: const Center(child: CircularProgressIndicator(color: Colors.white)),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white24),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: isLoading ? null : () => context.pop(),
                          child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: (isLoading || isAsset || isNetwork)
                              ? null
                              : () {
                                  context.read<AuthBloc>().add(UpdateAvatarRequested(imagePath: imagePath));
                                },
                          child: isLoading
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : const Text('حفظ كصورة شخصية', style: TextStyle(color: Colors.white, fontFamily: 'Cairo')),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
