import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileState {
  final File? image;
  final String name;
  final String email;
  final String gender;
  final String phone;

  ProfileState({
    this.image,
    this.name = '',
    this.email = '',
    this.gender = '',
    this.phone = '',
  });

  ProfileState copyWith({
    File? image,
    String? name,
    String? email,
    String? gender,
    String? phone,
  }) {
    return ProfileState(
      image: image ?? this.image,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
    );
  }
}

class ProfileController extends Notifier<ProfileState> {
  final ImagePicker _picker = ImagePicker();

  @override
  ProfileState build() {
    // يبدأ فارغاً - يتم تعبئته من AuthBloc عند تحميل الشاشة
    return ProfileState();
  }

  /// تحديث البيانات من كائن المستخدم القادم من الباك أند
  void syncFromUser({
    required String name,
    required String email,
    required String phone,
  }) {
    state = state.copyWith(
      name: name,
      email: email,
      phone: phone,
    );
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      state = state.copyWith(image: File(pickedFile.path));
    }
  }

  void updateField(String field, String value) {
    switch (field) {
      case 'name':
        state = state.copyWith(name: value);
        break;
      case 'email':
        state = state.copyWith(email: value);
        break;
      case 'gender':
        state = state.copyWith(gender: value);
        break;
      case 'phone':
        state = state.copyWith(phone: value);
        break;
    }
  }
}

final profileControllerProvider = NotifierProvider<ProfileController, ProfileState>(() {
  return ProfileController();
});
