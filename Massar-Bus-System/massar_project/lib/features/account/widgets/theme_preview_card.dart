import 'package:flutter/material.dart';

class ThemePreviewCard extends StatelessWidget {
  final String label;
  final bool isDark;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemePreviewCard({
    super.key,
    required this.label,
    required this.isDark,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCurrentThemeDark = theme.brightness == Brightness.dark;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1D2939) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? const Color(0xFF1570EF) : Colors.transparent,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Stylized Mini UI
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 12,
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF344054) : const Color(0xFFF2F4F7),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF344054) : const Color(0xFFF2F4F7),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF344054) : const Color(0xFFF2F4F7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 100,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF344054) : const Color(0xFFF2F4F7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 140,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF344054) : const Color(0xFFF2F4F7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: double.infinity,
                          height: 6,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1570EF),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isCurrentThemeDark ? Colors.white : const Color(0xFF1D2939),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
