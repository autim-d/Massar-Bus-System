import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:massar_project/core/constants/dummy_data.dart';

class ProfileState {
  final File? image;
  final String name;
  final String email;
  final String gender;
  final String phone;

  ProfileState({
    this.image,
    this.name = DummyData.userName,
    this.email = DummyData.userEmail,
    this.gender = DummyData.userGender,
    this.phone = DummyData.userPhone,
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
    return ProfileState();
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
