import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:massar_project/core/theme/bloc/theme_bloc.dart';
import 'package:massar_project/core/theme/bloc/theme_event.dart';
import 'package:massar_project/core/theme/bloc/theme_state.dart';

class HomeHeader extends StatelessWidget {
  final int notificationCount;
  final String greeting;
  final String userName;

  const HomeHeader({
    Key? key,
    this.notificationCount = 12,
    this.greeting = 'صباح الخير',
    this.userName = 'أحمد باجردانه',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Theme Toggle and Notification Bell
          Row(
            children: [
              // Theme Toggle Shortcut
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  // Determine effective brightness for icon selection
                  final effectiveIsDark = state.themeMode == ThemeMode.system
                      ? MediaQuery.of(context).platformBrightness == Brightness.dark
                      : state.themeMode == ThemeMode.dark;

                  return GestureDetector(
                    onTap: () {
                      context.read<ThemeBloc>().add(const ToggleTheme());
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        effectiveIsDark
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                        color: theme.iconTheme.color,
                        size: 24,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              // Notification Bell with Badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: theme.cardTheme.color,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: theme.iconTheme.color,
                      size: 24,
                    ),
                  ),
                  if (notificationCount > 0)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF04438), // Red badge
                          shape: BoxShape.circle,
                          border: Border.all(color: theme.cardTheme.color ?? Colors.white, width: 2),
                        ),
                        child: Text(
                          '$notificationCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            height: 1.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),

          // Menu and Greeting (Right aligned)
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    greeting,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.menu_rounded,
                    color: theme.iconTheme.color,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
