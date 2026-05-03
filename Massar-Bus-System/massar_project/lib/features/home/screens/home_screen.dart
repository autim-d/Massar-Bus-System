import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/home_header.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/quick_action_section.dart';
import '../widgets/active_ticket_card.dart';
import '../../../../core/widgets/custom_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_state.dart';

import '../../../../core/widgets/location_map_card.dart';
import '../../../../core/constants/api_constants.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentPosition;
  String _locationName = 'جاري تحديد الموقع...';
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) setState(() => _isLoadingLocation = false);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) setState(() => _isLoadingLocation = false);
        return;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      if (mounted) setState(() => _isLoadingLocation = false);
      return;
    } 

    final position = await Geolocator.getCurrentPosition();
    if (mounted) {
      setState(() {
        _currentPosition = position;
      });
      _getPlaceName(position.latitude, position.longitude);
    }
  }

  Future<void> _getPlaceName(double lat, double lng) async {
    try {
      final url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?access_token=${ApiConstants.mapboxPublicToken}&language=ar';
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['features'] != null && data['features'].isNotEmpty) {
          final placeName = data['features'][0]['place_name'];
          if (mounted) {
            setState(() {
              _locationName = placeName;
              _isLoadingLocation = false;
            });
          }
          return;
        }
      }
      if (mounted) setState(() => _locationName = 'موقع مجهول');
    } catch (e) {
      if (mounted) setState(() => _locationName = 'خطأ في تحديد الموقع');
    } finally {
      if (mounted) setState(() => _isLoadingLocation = false);
    }
  }

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
            Positioned.fill(
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          String name = 'User';
                          if (state is AuthAuthenticated) {
                            name = state.name;
                          } else if (state is AuthGuest) {
                            name = 'زائر';
                          } else if (state is AuthLoading) {
                            name = 'جاري التحميل...';
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: LocationMapCard(
                          key: ValueKey(_currentPosition?.latitude ?? 0.0),
                          title: 'موقعك الحالي',
                          locationDetails: _locationName,
                          position: _currentPosition,
                          mapboxPublicToken: ApiConstants.mapboxPublicToken,
                          isLoading: _isLoadingLocation,
                        ),
                      ),
                      const SizedBox(height: 24),
                      QuickActionSection(currentPosition: _currentPosition),
                      const SizedBox(height: 32),
                      const ActiveTicketCard(),
                      const SizedBox(height: 48), // Bottom padding
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
