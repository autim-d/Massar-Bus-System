import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Routing configuration helpers
import 'custom_transitions.dart';
import 'shell_navigation_screen.dart';

// ─── Auth & Onboarding ───────────────────────────────────────────────────────
import 'package:massar_project/features/auth/screens/splash_screen.dart';
import 'package:massar_project/features/onboarding/onboarding_screen.dart';
import 'package:massar_project/features/auth/screens/login_screen.dart';
import 'package:massar_project/features/auth/screens/phone_login_screen.dart';
import 'package:massar_project/features/auth/screens/enter_code_screen.dart';
import 'package:massar_project/features/auth/screens/verification_method_screen.dart';

import 'package:massar_project/features/auth/screens/sign_up_screen.dart';

// ─── Home ────────────────────────────────────────────────────────────────────
import 'package:massar_project/features/home/screens/home_screen.dart';
import 'package:massar_project/features/search/search_bus_screen.dart';
import 'package:massar_project/features/home/screens/location_search_screen.dart';
import 'package:massar_project/features/home/screens/bus_results_screen.dart';
import 'package:massar_project/features/home/screens/ticket_details_screen.dart';
import 'package:massar_project/features/home/models/trip_model.dart';
import 'package:massar_project/features/home/models/bus_ticket_model.dart';
import 'package:massar_project/features/home/models/bus_search_criteria.dart';
import 'package:massar_project/features/ticket/models/checkout_session_model.dart';

// ─── Tickets & Booking Flow ──────────────────────────────────────────────────
import 'package:massar_project/features/ticket/screens/ticket_list_screen.dart';
import 'package:massar_project/features/ticket/screens/ticket_status_screen.dart';
import 'package:massar_project/features/ticket/screens/my_ticket_details_screen.dart';
import 'package:massar_project/features/ticket/screens/order_summary_screen.dart';
import 'package:massar_project/features/ticket/screens/payment_method_screen.dart';
import 'package:massar_project/features/ticket/screens/payment_success_screen.dart';

// ─── Account / Profile ───────────────────────────────────────────────────────
import 'package:massar_project/features/account/screens/account_screen.dart';
import 'package:massar_project/features/account/screens/profile_screen.dart';
import 'package:massar_project/features/account/screens/edit_profile_screen.dart';
import 'package:massar_project/features/account/screens/edit_photo_screen.dart';
import 'package:massar_project/features/account/screens/account_details_form_screen.dart';
import 'package:massar_project/features/account/screens/settings_screen.dart';
import 'package:massar_project/features/account/screens/change_password_screen.dart';
import 'package:massar_project/features/account/screens/appearance_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
/// The centralized GoRouter for the Massar Bus System.
///
/// Architecture:
///   • Auth stack  (/, /onboarding, /login, /login/phone, /verification, /otp)
///     pushed outside the shell so no bottom nav is visible.
///   • Main shell  (StatefulShellRoute – 5 tabs)
///     Branch 0 → /home          (الصفحة الرئيسية)
///     Branch 1 → /tickets        (تذكرتي)
///     Branch 2 → /buy            (شراء — shortcut to SearchBusScreen)
///     Branch 3 → /booking        (حجز)
///     Branch 4 → /account        (الحساب)
///
/// Data passing strategy:
///   • Non-serialisable payloads (phone, image path) → GoRouterState.extra
///   • Ticket state is managed by ticketProvider (Riverpod) — no extra needed
///     for DetailTicketScreen.
// ─────────────────────────────────────────────────────────────────────────────
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // ──────────────────────────────────────────────────────────────────────────
    // AUTH & INITIALISATION  (outside shell — no bottom nav bar)
    // ──────────────────────────────────────────────────────────────────────────
    GoRoute(
      path: '/',
      name: 'splash',
      // No transition override — default is fine for the very first frame.
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      pageBuilder: (context, state) => MassarTransitions.fade(
        context: context,
        state: state,
        child: const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) => MassarTransitions.parallaxSlideUp(
        context: context,
        state: state,
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      pageBuilder: (context, state) => MassarTransitions.slideLeft(
        context: context,
        state: state,
        child: const SignUpScreen(),
      ),
    ),
    GoRoute(
      path: '/login/phone',
      name: 'phoneLogin',
      pageBuilder: (context, state) => MassarTransitions.slideLeft(
        context: context,
        state: state,
        child: const PhoneLoginScreen(),
      ),
    ),
    GoRoute(
      path: '/verification',
      name: 'verification',
      // extra: String — the full phone number (e.g. "+967 777777777")
      pageBuilder: (context, state) => MassarTransitions.fade(
        context: context,
        state: state,
        child: VerificationMethodScreen(
          phoneNumber: state.extra as String? ?? '',
        ),
      ),
    ),
    GoRoute(
      path: '/otp',
      name: 'otp',
      // extra: String — phone number forwarded from verification screen
      pageBuilder: (context, state) => MassarTransitions.fade(
        context: context,
        state: state,
        child: EnterCodeScreen(
          phoneNumber: state.extra as String? ?? '',
        ),
      ),
    ),

    // ──────────────────────────────────────────────────────────────────────────
    // MAIN APP SHELL  (persistent 5-tab bottom navigation)
    // ──────────────────────────────────────────────────────────────────────────
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ShellNavigationScreen(navigationShell: navigationShell);
      },
      branches: [
        // ── Branch 0: Home (الصفحة الرئيسية) ──────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              pageBuilder: (context, state) => MassarTransitions.fade(
                context: context,
                state: state,
                child: const HomeScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'search',
                  name: 'homeSearch',
                  pageBuilder: (context, state) => MassarTransitions.sharedAxisZ(
                    context: context,
                    state: state,
                    child: const SearchBusScreen(),
                  ),
                ),
                GoRoute(
                  path: 'location',
                  name: 'locationSearch',
                  pageBuilder: (context, state) => MassarTransitions.parallaxSlideUp(
                    context: context,
                    state: state,
                    child: LocationSearchScreen(
                      isOriginInitialFocus: state.extra as bool? ?? true,
                    ),
                  ),
                ),
                GoRoute(
                  path: 'results',
                  name: 'busResults',
                  pageBuilder: (context, state) => MassarTransitions.slideLeft(
                    context: context,
                    state: state,
                    child: BusResultsScreen(
                      criteria: state.extra as BusSearchCriteria?,
                    ),
                  ),
                ),
                GoRoute(
                  path: 'ticket-details',
                  name: 'ticketDetails',
                  pageBuilder: (context, state) => MassarTransitions.slideLeft(
                    context: context,
                    state: state,
                    child: TicketDetailsScreen(
                      ticket: state.extra as BusTicketModel,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        // ── Branch 1: Tickets (تذكرتي) ──────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tickets',
              name: 'tickets',
              pageBuilder: (context, state) => MassarTransitions.fade(
                context: context,
                state: state,
                child: const TicketStatusScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'my-ticket',
                  name: 'myTicket',
                  pageBuilder: (context, state) => MassarTransitions.slideLeft(
                    context: context,
                    state: state,
                    child: MyTicketDetailsScreen(
                      session: state.extra as CheckoutSessionModel,
                    ),
                  ),
                ),
                GoRoute(
                  path: 'order-summary',
                  name: 'orderSummary',
                  // extra: TripModel — passed from results screen
                  pageBuilder: (context, state) => MassarTransitions.parallaxSlideUp(
                    context: context,
                    state: state,
                    child: OrderSummaryScreen(
                      trip: state.extra as TripModel?,
                    ),
                  ),
                ),
                GoRoute(
                  path: 'payment',
                  name: 'payment',
                  pageBuilder: (context, state) => MassarTransitions.parallaxSlideUp(
                    context: context,
                    state: state,
                    child: PaymentMethodScreen(
                      ticket: state.extra as BusTicketModel,
                    ),
                  ),
                ),
                GoRoute(
                  path: 'payment/success',
                  name: 'paymentSuccess',
                  pageBuilder: (context, state) => MassarTransitions.elasticReveal(
                    context: context,
                    state: state,
                    child: PaymentSuccessScreen(
                      session: state.extra as CheckoutSessionModel?,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        // ── Branch 2: Buy / شراء (direct entry to SearchBusScreen) ────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/buy',
              name: 'buy',
              pageBuilder: (context, state) => MassarTransitions.sharedAxisZ(
                context: context,
                state: state,
                child: const SearchBusScreen(),
              ),
            ),
          ],
        ),

        // ── Branch 3: Booking / حجز ───────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/booking',
              name: 'booking',
              pageBuilder: (context, state) => MassarTransitions.fade(
                context: context,
                state: state,
                child: const TicketListScreen(),
              ),
            ),
          ],
        ),

        // ── Branch 4: Account / الحساب ──────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/account',
              name: 'account',
              pageBuilder: (context, state) => MassarTransitions.fade(
                context: context,
                state: state,
                // AccountScreen is the visual shell root: profile header +
                // settings cards. It no longer owns a BottomNavigationBar
                // (to be removed in Phase C).
                child: const AccountScreen(),
              ),
              routes: [
                // Personal-fields editor (Riverpod-backed ProfileScreen)
                GoRoute(
                  path: 'profile',
                  name: 'accountProfile',
                  pageBuilder: (context, state) => MassarTransitions.slideLeft(
                    context: context,
                    state: state,
                    child: const ProfileScreen(),
                  ),
                ),
                // Full edit-profile form (EditProfileScreen)
                GoRoute(
                  path: 'edit',
                  name: 'editProfile',
                  pageBuilder: (context, state) => MassarTransitions.sharedAxisZ(
                    context: context,
                    state: state,
                    child: const EditProfileScreen(),
                  ),
                ),
                // Avatar / photo editor
                // extra: String — current image asset/file path
                GoRoute(
                  path: 'edit-photo',
                  name: 'editPhoto',
                  pageBuilder: (context, state) => MassarTransitions.fade(
                    context: context,
                    state: state,
                    child: EditPhotoScreen(
                      currentImage: state.extra as String? ??
                          'assets/images/defulte.jpg',
                    ),
                  ),
                ),
                // Account details / passenger info form
                GoRoute(
                  path: 'details-form',
                  name: 'accountDetailsForm',
                  pageBuilder: (context, state) => MassarTransitions.slideLeft(
                    context: context,
                    state: state,
                    child: const AccountDetailsFormScreen(),
                  ),
                ),
                GoRoute(
                  path: 'settings',
                  name: 'settings',
                  pageBuilder: (context, state) => MassarTransitions.slideLeft(
                    context: context,
                    state: state,
                    child: const SettingsScreen(),
                  ),
                  routes: [
                    GoRoute(
                      path: 'password',
                      name: 'changePassword',
                      pageBuilder: (context, state) => MassarTransitions.slideLeft(
                        context: context,
                        state: state,
                        child: const ChangePasswordScreen(),
                      ),
                    ),
                    GoRoute(
                      path: 'appearance',
                      name: 'appearance',
                      pageBuilder: (context, state) => MassarTransitions.slideLeft(
                        context: context,
                        state: state,
                        child: const AppearanceScreen(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

// ─────────────────────────────────────────────────────────────────────────────
/// Temporary placeholder shown for the Promotions tab until a real screen
/// is designed and implemented.
// ─────────────────────────────────────────────────────────────────────────────
class _PromotionsPlaceholderScreen extends StatelessWidget {
  const _PromotionsPlaceholderScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_offer_outlined,
              size: 72,
              color: const Color(0xFF1570EF).withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'الترويج',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1D2939),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'قريبًا',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF667085),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
