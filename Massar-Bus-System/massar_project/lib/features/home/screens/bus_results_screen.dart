import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../providers/bus_search_provider.dart';
import '../providers/search_location_provider.dart';
import '../models/bus_search_criteria.dart';
import '../widgets/components/bus_result_card.dart';
import '../widgets/components/date_price_selector_item.dart';

class BusResultsScreen extends ConsumerStatefulWidget {
  final BusSearchCriteria? criteria;
  const BusResultsScreen({super.key, this.criteria});

  @override
  ConsumerState<BusResultsScreen> createState() => _BusResultsScreenState();
}

class _BusResultsScreenState extends ConsumerState<BusResultsScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final locationState = ref.watch(searchLocationProvider);
    final searchCriteria = widget.criteria?.copyWith(date: selectedDate) ??
        BusSearchCriteria(
          fromId: locationState.currentLocation?.id,
          toId: locationState.destination?.id,
          from: locationState.currentLocation?.name ?? '',
          to: locationState.destination?.name ?? '',
          date: selectedDate,
        );
    final ticketsAsync = ref.watch(busSearchProvider(searchCriteria));

    final destinationName =
        locationState.destination?.name ?? 'Monumen Nasional';

    return Directionality(
      textDirection:
          TextDirection.ltr, // To match the mock exact english/arabic mixed layout
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: isDark ? const Color(0xFF1D2939) : Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.close,
                color: isDark ? Colors.white : Colors.black),
            onPressed: () => context.pop(),
          ),
          title: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFE85C0D),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destinationName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    Text(
                      'RT.5/RW.2, Gambir, Central Jakarta City...',
                      style: TextStyle(
                        fontSize: 10,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.tune,
                  color: isDark ? Colors.white : Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // Date Selector (Horizontal List)
            Container(
              color: isDark ? const Color(0xFF1D2939) : Colors.white,
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  final date = DateTime.now().add(Duration(days: index));
                  return DatePriceSelectorItem(
                    date: date,
                    price: 10000,
                    isSelected: date.day == selectedDate.day,
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                      // Normally we'd fetch new results here via Riverpod
                      // ref.refresh(busSearchProvider);
                    },
                  );
                },
              ),
            ),

            // Bus Results
            Expanded(
              child: ticketsAsync.when(
                data: (tickets) {
                  if (tickets.isEmpty) {
                    return const Center(child: Text('No buses found.'));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      return BusResultCard(ticket: tickets[index]);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF1570EF))),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
