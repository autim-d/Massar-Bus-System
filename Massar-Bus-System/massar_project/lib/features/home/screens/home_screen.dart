import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/home_header.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/quick_action_section.dart';
import '../widgets/active_ticket_card.dart';
import '../../../../core/widgets/custom_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          TextDirection.rtl, // Ensuring RTL for the entire screen layout
      child: Scaffold(
        drawer: const CustomDrawer(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            // Faded Pattern Background
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 250,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/images/map.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
            ),

            // Main Content
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        String name = 'أحمد باجردانه';
                        if (state is AuthAuthenticated) {
                          name = state.name;
                        } else if (state is AuthGuest) {
                          name = 'زائر';
                        }
                        return HomeHeader(
                          notificationCount: 12,
                          greeting: 'صباح الخير',
                          userName: name,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    HomeSearchBar(
                      onTap: () => context.pushNamed('homeSearch'),
                    ),
                    const SizedBox(height: 24),
                    const QuickActionSection(),
                    const SizedBox(height: 32),
                    const ActiveTicketCard(),
                    const SizedBox(height: 48), // Bottom padding
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
