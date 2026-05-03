import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/components/location_input_connector.dart';
import '../providers/search_location_provider.dart';
import '../models/location_model.dart';

class LocationSearchScreen extends ConsumerStatefulWidget {
  final bool isOriginInitialFocus;
  const LocationSearchScreen({super.key, this.isOriginInitialFocus = true});

  @override
  ConsumerState<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends ConsumerState<LocationSearchScreen> {
  late TextEditingController originController;
  late TextEditingController destinationController;
  late FocusNode originFocusNode;
  late FocusNode destinationFocusNode;

  @override
  void initState() {
    super.initState();
    final state = ref.read(searchLocationProvider);
    originController = TextEditingController(text: state.currentLocation?.name ?? '');
    destinationController = TextEditingController(text: state.destination?.name ?? '');
    originFocusNode = FocusNode();
    destinationFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isOriginInitialFocus) {
        originFocusNode.requestFocus();
      } else {
        destinationFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    originController.dispose();
    destinationController.dispose();
    originFocusNode.dispose();
    destinationFocusNode.dispose();
    super.dispose();
  }

  void _onDestinationSubmitted(String value) {
    // Basic mock update
    if (value.isNotEmpty) {
      ref.read(searchLocationProvider.notifier).updateDestination(
        LocationModel(id: 'dest_1', name: value),
      );
      // Navigate to results
      context.push('/home/results');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: theme.appBarTheme.backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.close, color: theme.iconTheme.color),
              onPressed: () => context.pop(),
            ),
            title: Text(
              "اين تريد الذهاب ؟",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: theme.textTheme.titleLarge?.color,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LocationInputConnector(
                  originController: originController,
                  destinationController: destinationController,
                  originFocusNode: originFocusNode,
                  destinationFocusNode: destinationFocusNode,
                  onOriginTap: () {},
                  onDestinationTap: () {},
                  onDestinationSubmitted: _onDestinationSubmitted,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildQuickActionChip(
                      context,
                      icon: Icons.bookmark,
                      label: "حفظ الموقع",
                      onTap: () {},
                    ),
                    const SizedBox(width: 12),
                    _buildQuickActionChip(
                      context,
                      icon: Icons.business_center,
                      label: "مكاتب التخزين",
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? Colors.white.withValues(alpha: 0.1) : const Color(0xFFE4E7EC),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: theme.textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              icon,
              size: 18,
              color: isDark ? theme.textTheme.bodySmall?.color : const Color(0xFF667085),
            ),
          ],
        ),
      ),
    );
  }
}
