import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProtectionPromoBanner extends StatefulWidget {
  const ProtectionPromoBanner({super.key});

  @override
  State<ProtectionPromoBanner> createState() => _ProtectionPromoBannerState();
}

class _ProtectionPromoBannerState extends State<ProtectionPromoBanner> {
  bool _isProtected = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFE85C0D)), // Orange border
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFFFDB022), // Yellow/Orange banner
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.favorite, color: Color(0xFFE85C0D), size: 24),
                    Positioned(
                      bottom: -4,
                      right: -4,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check_circle, color: Color(0xFFFDB022), size: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                const Text(
                  'احصل على حمايه اضافيه لرحلتك',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ReadexPro',
                  ),
                ),
              ],
            ),
          ),

          // Content Options
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'اختار خيار واحد فقط',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFE85C0D),
                    fontFamily: 'ReadexPro',
                  ),
                ),
                const SizedBox(height: 12),

                // Option 1: Protect
                InkWell(
                  onTap: () {
                    setState(() {
                      _isProtected = true;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        _isProtected ? Icons.check_box : Icons.check_box_outline_blank,
                        color: _isProtected ? const Color(0xFF1570EF) : (isDark ? Colors.white24 : const Color(0xFFD0D5DD)),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(LucideIcons.shieldCheck, size: 16, color: theme.textTheme.bodyLarge?.color),
                                const SizedBox(width: 8),
                                Text(
                                  'ضمان الحمايه',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: theme.textTheme.bodyLarge?.color,
                                    fontFamily: 'ReadexPro',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'احصل على استرداد يصل الى 100% من اموالك مقابل خدمة سيئه',
                              style: TextStyle(
                                fontSize: 10,
                                color: isDark ? theme.textTheme.bodySmall?.color : const Color(0xFF667085),
                                fontFamily: 'ReadexPro',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Option 2: Don't protect
                InkWell(
                  onTap: () {
                    setState(() {
                      _isProtected = false;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        !_isProtected ? Icons.check_box : Icons.check_box_outline_blank,
                        color: !_isProtected ? const Color(0xFF1570EF) : (isDark ? Colors.white24 : const Color(0xFFD0D5DD)),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Icon(LucideIcons.shieldClose, size: 16, color: theme.textTheme.bodyLarge?.color),
                      const SizedBox(width: 8),
                      Text(
                        'لا اريد الحمايه',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyLarge?.color,
                          fontFamily: 'ReadexPro',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
