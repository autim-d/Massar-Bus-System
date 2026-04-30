import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/repositories/station_repository.dart';
import '../../../../core/models/station_model.dart';

class QuickActionSection extends ConsumerStatefulWidget {
  final Position? currentPosition;

  const QuickActionSection({Key? key, this.currentPosition}) : super(key: key);

  @override
  ConsumerState<QuickActionSection> createState() => _QuickActionSectionState();
}

class _QuickActionSectionState extends ConsumerState<QuickActionSection> {
  late Future<List<StationModel>> _stationsFuture;
  final List<String> fallbackPlaces = [
    "الشافعي", "إبن سينا", "المساكن", "مستشفى النور", 
    "العمودي المتضررين", "رئاسة الجامعة", "أبراج بن محفوظ", 
    "باعبود", "الجسر", "الشرج"
  ];

  @override
  void initState() {
    super.initState();
    _stationsFuture = ref.read(stationRepositoryProvider).getStations();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: FutureBuilder<List<StationModel>>(
        future: _stationsFuture,
        builder: (context, snapshot) {
          List<String> displayPlaces = fallbackPlaces.take(3).toList();

          if (snapshot.hasData && snapshot.data != null) {
            final stations = List<StationModel>.from(snapshot.data!);
            if (widget.currentPosition != null) {
              stations.sort((a, b) {
                final distA = Geolocator.distanceBetween(
                  widget.currentPosition!.latitude, widget.currentPosition!.longitude, 
                  a.latitude, a.longitude
                );
                final distB = Geolocator.distanceBetween(
                  widget.currentPosition!.latitude, widget.currentPosition!.longitude, 
                  b.latitude, b.longitude
                );
                return distA.compareTo(distB);
              });
            }
            displayPlaces = stations.take(3).map((e) => e.name).toList();
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            scrollDirection: Axis.horizontal,
            reverse: true, // Right-to-left scrolling behavior usually desired for RTL
            itemCount: displayPlaces.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return _QuickActionChip(placeName: displayPlaces[index]);
            },
          );
        },
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  final String placeName;

  const _QuickActionChip({required this.placeName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: 140, // Fixed width based on UI proportion
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1D2939) : const Color(0xFFF2F4F7),
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
              color: theme.textTheme.bodyMedium?.color,
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
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                Icons.location_on_rounded,
                size: 16,
                color: theme.iconTheme.color,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
