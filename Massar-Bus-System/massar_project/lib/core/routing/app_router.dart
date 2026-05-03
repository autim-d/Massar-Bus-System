import 'package:massar_project/core/theme/app_colors.dart';
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

// ─────────────────────────────────────────────────────────────────────────────
/// The centralized GoRouter for the Massar Bus System.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // ──────────────────────────────────────────────────────────────────────────
    // AUTH & INITIALISATION  (outside shell — no bottom nav bar)
    // ──────────────────────────────────────────────────────────────────────────
    GoRoute(
      path: '/',
      name: 'splash',
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
        // ── Branch 0: Home ────────────────────────────────────────────────────
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

        // ── Branch 1: Tickets ─────────────────────────────────────────────────
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

        // ── Branch 2: Buy ─────────────────────────────────────────────────────
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

        // ── Branch 3: Booking ─────────────────────────────────────────────────
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

        // ── Branch 4: Account ─────────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/account',
              name: 'account',
              pageBuilder: (context, state) => MassarTransitions.fade(
                context: context,
                state: state,
                child: const AccountScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'profile',
                  name: 'accountProfile',
                  pageBuilder: (context, state) => MassarTransitions.slideLeft(
                    context: context,
                    state: state,
                    child: const ProfileScreen(),
                  ),
                ),
                GoRoute(
                  path: 'edit',
                  name: 'editProfile',
                  pageBuilder: (context, state) => MassarTransitions.sharedAxisZ(
                    context: context,
                    state: state,
                    child: const EditProfileScreen(),
                  ),
                ),
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
