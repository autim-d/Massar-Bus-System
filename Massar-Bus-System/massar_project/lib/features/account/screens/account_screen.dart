import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:massar_project/core/theme/app_colors.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_state.dart';
import 'package:massar_project/features/account/widgets/profile_header_widget.dart';
import 'package:massar_project/features/account/widgets/account_settings_card_widget.dart';
import 'package:massar_project/features/account/widgets/support_settings_card_widget.dart';
import 'package:massar_project/features/account/widgets/guest_profile_placeholder.dart';
import 'package:massar_project/features/account/models/user_model.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  UserModel? _lastUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthGuest) {
            return const SafeArea(
              child: Center(
                child: GuestProfilePlaceholder(),
              ),
            );
          }

          if (state is AuthAuthenticated) {
            _lastUser = state.user;
          } else if (state is ProfileUpdateSuccess) {
            _lastUser = state.user;
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/images/h.jpg',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        left: 20,
                        right: 20,
                        top: 45,
                        child: ProfileHeaderWidget(
                          name: _lastUser != null ? '${_lastUser!.firstName} ${_lastUser!.lastName}' : null,
                          email: _lastUser?.email,
                          imageUrl: _lastUser?.profileImage,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 29),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        AccountSettingsCardWidget(),
                        SizedBox(height: 25),
                        SupportSettingsCardWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
