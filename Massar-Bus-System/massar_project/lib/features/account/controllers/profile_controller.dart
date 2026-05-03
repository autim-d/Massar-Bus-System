import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:massar_project/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileState {
  final File? image;
  final String name;
  final String email;
  final String gender;
  final String phone;
  final String? avatarUrl;
  final bool isLoading;

  ProfileState({
    this.image,
    this.name = '',
    this.email = '',
    this.gender = '',
    this.phone = '',
    this.avatarUrl,
    this.isLoading = true,
  });

  ProfileState copyWith({
    File? image,
    String? name,
    String? email,
    String? gender,
    String? phone,
    String? avatarUrl,
    bool? isLoading,
  }) {
    return ProfileState(
      image: image ?? this.image,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ProfileController extends Notifier<ProfileState> {
  final ImagePicker _picker = ImagePicker();

  @override
  ProfileState build() {
    // Start loading data immediately
    _loadProfile();
    return ProfileState();
  }

  Future<void> _loadProfile() async {
    final authRepo = ref.read(authRepositoryProvider);
    try {
      final userResponse = await authRepo.getDashboardData();
      final user = userResponse['user'];
      
      if (user != null) {
        String fullName = '${user['first_name'] ?? ''} ${user['last_name'] ?? ''}'.trim();
        if (fullName.isEmpty) fullName = 'User';
        
        state = state.copyWith(
          name: fullName,
          email: user['email'] ?? '',
          gender: user['gender'] ?? 'ذكر',
          phone: user['phone_number'] ?? '',
          avatarUrl: user['avatar_url'],
          isLoading: false,
        );
      }

    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      state = state.copyWith(image: File(pickedFile.path));
    }
  }

  void updateField(String field, String value) {
    // In a real app, you would also call authRepo.updateProfile here
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
