import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:massar_project/core/theme/bloc/theme_bloc.dart';
import 'package:massar_project/core/theme/bloc/theme_event.dart';
import 'package:massar_project/core/theme/bloc/theme_state.dart';
import '../widgets/theme_preview_card.dart';
import '../widgets/theme_selection_tile.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المظهر'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            final currentMode = state.themeMode;
            
            // Determine which preview card should be highlighted if "System" is selected
            final systemIsDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
            final effectiveIsDark = currentMode == ThemeMode.system ? systemIsDark : currentMode == ThemeMode.dark;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Preview Section ---
                  Text(
                    'معاينة',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'ReadexPro',
                      color: theme.textTheme.titleLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ThemePreviewCard(
                        label: 'فاتح',
                        isDark: false,
                        isSelected: !effectiveIsDark,
                        onTap: () => context.read<ThemeBloc>().add(const ChangeTheme(ThemeMode.light)),
                      ),
                      const SizedBox(width: 16),
                      ThemePreviewCard(
                        label: 'داكن',
                        isDark: true,
                        isSelected: effectiveIsDark,
                        onTap: () => context.read<ThemeBloc>().add(const ChangeTheme(ThemeMode.dark)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // --- Theme Selection Section ---
                  Text(
                    'السمة',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'ReadexPro',
                      color: theme.textTheme.titleLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.cardTheme.color,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: theme.dividerColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        ThemeSelectionTile(
                          title: 'افتراضي النظام',
                          subtitle: 'التكيف مع إعدادات جهازك',
                          icon: Icons.important_devices_rounded,
                          isSelected: currentMode == ThemeMode.system,
                          onTap: () => context.read<ThemeBloc>().add(const ChangeTheme(ThemeMode.system)),
                        ),
                        _buildDivider(theme),
                        ThemeSelectionTile(
                          title: 'فاتح',
                          subtitle: 'مظهر مشرق للتطبيق',
                          icon: Icons.wb_sunny_outlined,
                          isSelected: currentMode == ThemeMode.light,
                          onTap: () => context.read<ThemeBloc>().add(const ChangeTheme(ThemeMode.light)),
                        ),
                        _buildDivider(theme),
                        ThemeSelectionTile(
                          title: 'داكن',
                          subtitle: 'مريح للعين في الإضاءة الخافتة',
                          icon: Icons.nightlight_outlined,
                          isSelected: currentMode == ThemeMode.dark,
                          onTap: () => context.read<ThemeBloc>().add(const ChangeTheme(ThemeMode.dark)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDivider(ThemeData theme) {
    return Divider(
      height: 1,
      thickness: 1,
      color: theme.dividerColor,
      indent: 16,
      endIndent: 16,
    );
  }
}
