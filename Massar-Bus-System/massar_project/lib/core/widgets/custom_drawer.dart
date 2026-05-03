import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_event.dart';
import 'package:massar_project/features/auth/bloc/auth_state.dart';
import 'custom_drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final drawerBgColor = isDark
        ? const Color(0xFF1E2939).withValues(alpha: 0.5)
        : const Color(0xFF1570EF).withValues(alpha: 0.5);

    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        children: [
          // Extremely pronounced frosted glass background
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Container(color: drawerBgColor),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(LucideIcons.x, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthAuthenticated) {
                              return Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: state.avatarUrl.startsWith('http')
                                        ? NetworkImage(state.avatarUrl) as ImageProvider
                                        : AssetImage(state.avatarUrl),
                                    backgroundColor: Colors.white24,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    state.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ReadexPro',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    state.email,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.8),
                                      fontSize: 14,
                                      fontFamily: 'ReadexPro',
                                    ),
                                  ),
                                ],
                              );
                            } else if (state is AuthGuest) {
                              return Column(
                                children: [
                                  const CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.white24,
                                    child: Icon(
                                      LucideIcons.user,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'زائر',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'ReadexPro',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'ضيف',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.8),
                                      fontSize: 14,
                                      fontFamily: 'ReadexPro',
                                    ),
                                  ),
                                ],
                              );
                            }
                            return const CircularProgressIndicator(
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Menu items
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      CustomDrawerItem(
                        icon: LucideIcons.home,
                        title: 'الرئيسية',
                        onTap: () {
                          Navigator.of(context).pop();
                          context.go('/home');
                        },
                      ),
                      CustomDrawerItem(
                        icon: LucideIcons.settings,
                        title: 'الإعدادات',
                        onTap: () {
                          Navigator.of(context).pop();
                          context.push('/account/settings');
                        },
                      ),
                      CustomDrawerItem(
                        icon: LucideIcons.user,
                        title: 'الملف الشخصي',
                        onTap: () {
                          Navigator.of(context).pop();
                          context.push('/account/profile');
                        },
                      ),
                      CustomDrawerItem(
                        icon: LucideIcons.ticket,
                        title: 'البحث عن تذكرة',
                        onTap: () {
                          Navigator.of(context).pop();
                          context.push('/home/search');
                        },
                      ),
                    ],
                  ),
                ),

                // Footer
                Column(
                  children: [
                    Divider(color: Colors.white.withValues(alpha: 0.2), height: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final isGuest = state is AuthGuest;
                          return CustomDrawerItem(
                            icon: isGuest
                                ? LucideIcons.logIn
                                : LucideIcons.logOut,
                            title: isGuest ? 'تسجيل الدخول' : 'تسجيل الخروج',
                            onTap: () {
                              Navigator.of(context).pop();
                              if (!isGuest) {
                                context.read<AuthBloc>().add(
                                  const LogoutRequested(),
                                );
                              }
                              context.go('/login');
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
