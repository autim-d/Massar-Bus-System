import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_state.dart';

class QuickActionSection extends StatelessWidget {
  const QuickActionSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        List<String> places = [];

        if (state is AuthAuthenticated && state.suggestedStations != null) {
          places = state.suggestedStations!
              .map((s) => s['name'] as String)
              .toList();
        }

        if (places.isEmpty) {
          // Fallback placeholders if no data yet
          places = ['المساكن', 'المكلا', 'الشحر'];
        }

        return SizedBox(
          height: 72,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            scrollDirection: Axis.horizontal,
            reverse: true, // Right-to-left scrolling behavior usually desired for RTL
            itemCount: places.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return _QuickActionChip(placeName: places[index]);
            },
          ),
        );
      },
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  final String placeName;

  const _QuickActionChip({required this.placeName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140, // Fixed width based on UI proportion
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F7),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'إحجز تذكرة إلى',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                placeName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.location_on_rounded,
                size: 16,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
