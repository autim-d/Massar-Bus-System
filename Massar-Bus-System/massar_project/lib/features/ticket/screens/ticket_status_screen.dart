import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/ticket_status_bloc/ticket_status_bloc.dart';
import '../widgets/components/filter_chip_row.dart';
import '../widgets/components/ticket_status_card.dart';

class TicketStatusScreen extends StatelessWidget {
  const TicketStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'حالة التذاكر',
            style: TextStyle(
              color: theme.textTheme.titleLarge?.color,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: theme.iconTheme.color),
              onPressed: () {
                // Search action
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // Filter section
            Container(
              color: theme.appBarTheme.backgroundColor,
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 8.0),
              child: BlocBuilder<TicketStatusBloc, TicketStatusState>(
                builder: (context, state) {
                  if (state is TicketStatusLoaded) {
                    return FilterChipRow(
                      filters: const [
                        'جميع الحالات',
                        'بأنتظار الدفع',
                        'النشطة',
                        'المكتملة',
                        'ملغاة',
                      ],
                      activeFilter: state.activeFilter,
                      onFilterSelected: (filter) {
                        context
                            .read<TicketStatusBloc>()
                            .add(FilterTicketsRequested(filter));
                      },
                    );
                  }
                  return const SizedBox(height: 50); // Placeholder while loading
                },
              ),
            ),

            // List section
            Expanded(
              child: BlocBuilder<TicketStatusBloc, TicketStatusState>(
                builder: (context, state) {
                  if (state is TicketStatusLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Color(0xFF1570EF)),
                    );
                  } else if (state is TicketStatusLoaded) {
                    final tickets = state.filteredTickets;
                    if (tickets.isEmpty) {
                      return Center(
                        child: Text(
                          'لا توجد تذاكر في هذه الحالة',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        return TicketStatusCard(ticket: tickets[index]);
                      },
                    );
                  } else if (state is TicketStatusError) {
                    return Center(
                      child: Text('Error: ${state.message}',
                          style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
