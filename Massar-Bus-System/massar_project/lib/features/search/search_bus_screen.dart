import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/custom_text_field.dart';
import 'package:geolocator/geolocator.dart';
import '../../location_fun.dart';
import '../../core/constants/api_constants.dart';

class SearchBusScreen extends StatefulWidget {
  const SearchBusScreen({Key? key}) : super(key: key);

  @override
  State<SearchBusScreen> createState() => _SearchBusScreenState();
}

class _SearchBusScreenState extends State<SearchBusScreen> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  
  final List<String> fallbackPlaces = [
    "الشافعي", "إبن سينا", "المساكن", "مستشفى النور", 
    "العمودي المتضررين", "رئاسة الجامعة", "أبراج بن محفوظ", 
    "باعبود", "الجسر", "الشرج"
  ];

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    
    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition();
    final neighborhood = await getCurrentNeighborhood(position, ApiConstants.mapboxPublicToken);
    
    if (mounted) {
      setState(() {
        _fromController.text = neighborhood;
      });
    }
  }

  void _showDestinationBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: fallbackPlaces.length,
            itemBuilder: (context, index) {
              final place = fallbackPlaces[index];
              return ListTile(
                leading: const Icon(Icons.location_on, color: AppColors.primaryBlue),
                title: Text(
                  place,
                  style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  setState(() {
                    _toController.text = place;
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'البحث عن الباص',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: theme.textTheme.titleLarge?.color ?? AppColors.textPrimary,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: theme.iconTheme,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.dividerColor,
                ),
              ),
              child: Column(
                children: [
                  CustomTextField(
                    controller: _fromController,
                    hintText: 'موقعك الحالي',
                    label: 'من',
                    readOnly: true,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _toController,
                    hintText: 'ابحث عن وجهة',
                    label: 'إلى',
                    readOnly: true,
                    onTap: _showDestinationBottomSheet,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'البحث عن موقع',
              onPressed: () {
                // Perform search
              },
            ),
            const SizedBox(height: 24),
            // Placeholder for saved locations
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'مكاتب التخزين',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.dividerColor,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: theme.iconTheme.color),
                  const SizedBox(width: 12),
                  Text(
                    'المساكن',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'حفظ الموقع',
                    style: TextStyle(
                      color: theme.textTheme.bodySmall?.color,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
