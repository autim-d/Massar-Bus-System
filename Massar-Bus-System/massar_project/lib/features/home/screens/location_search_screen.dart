import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/components/location_input_connector.dart';
import '../providers/search_location_provider.dart';
import '../providers/stations_provider.dart';
import '../models/location_model.dart';
import '../models/bus_search_criteria.dart';
import '../../../core/models/station_model.dart';

class LocationSearchScreen extends ConsumerStatefulWidget {
  final bool isOriginInitialFocus;

  const LocationSearchScreen({
    super.key,
    this.isOriginInitialFocus = true,
  });

  @override
  ConsumerState<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends ConsumerState<LocationSearchScreen> {
  late TextEditingController originController;
  late TextEditingController destinationController;
  late TextEditingController passengerNameController;
  late TextEditingController passengerPhoneController;
  late FocusNode originFocusNode;
  late FocusNode destinationFocusNode;
  late FocusNode passengerNameFocusNode;
  late FocusNode passengerPhoneFocusNode;
  bool isOriginFocused = true;

  @override
  void initState() {
    super.initState();
    isOriginFocused = widget.isOriginInitialFocus;
    final state = ref.read(searchLocationProvider);
    originController = TextEditingController(text: state.currentLocation?.name ?? '');
    destinationController = TextEditingController(text: state.destination?.name ?? '');
    passengerNameController = TextEditingController();
    passengerPhoneController = TextEditingController();
    
    originFocusNode = FocusNode();
    destinationFocusNode = FocusNode();
    passengerNameFocusNode = FocusNode();
    passengerPhoneFocusNode = FocusNode();

    // إضافة مستمعين لتغيير الحالة عند كتابة نص
    originController.addListener(() => setState(() {}));
    destinationController.addListener(() => setState(() {}));
    passengerNameController.addListener(() => setState(() {}));
    passengerPhoneController.addListener(() => setState(() {}));

    // التركيز التلقائي
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isOriginFocused) {
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
    passengerNameController.dispose();
    passengerPhoneController.dispose();
    originFocusNode.dispose();
    destinationFocusNode.dispose();
    passengerNameFocusNode.dispose();
    passengerPhoneFocusNode.dispose();
    super.dispose();
  }

  void _onStationSelected(StationModel station) {
    if (isOriginFocused) {
      ref.read(searchLocationProvider.notifier).updateCurrentLocation(
            LocationModel(
              id: station.id.toString(),
              name: station.name,
              description: station.city,
            ),
          );
      originController.text = station.name;
      // بعد اختيار المنطلق، نركز على الوجهة تلقائياً إذا كانت فارغة
      if (destinationController.text.isEmpty) {
        setState(() => isOriginFocused = false);
        destinationFocusNode.requestFocus();
      }
    } else {
      ref.read(searchLocationProvider.notifier).updateDestination(
            LocationModel(
              id: station.id.toString(),
              name: station.name,
              description: station.city,
            ),
          );
      destinationController.text = station.name;
    }

    // تم إزالة الانتقال التلقائي للسماح بإدخال بيانات المسافر قبل البحث
  }

  @override
  Widget build(BuildContext context) {
    final stationsAsync = ref.watch(stationsProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.close, color: AppColors.textPrimary),
              onPressed: () => context.pop(),
            ),
            title: Text(
              "اين تريد الذهاب ؟",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
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
                  onOriginTap: () => setState(() => isOriginFocused = true),
                  onDestinationTap: () => setState(() => isOriginFocused = false),
                  onDestinationSubmitted: (val) {},
                ),
                const SizedBox(height: 16),

                // Passenger Info Form
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE4E7EC),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "بيانات المسافر",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: passengerNameController,
                        focusNode: passengerNameFocusNode,
                        decoration: InputDecoration(
                          hintText: 'اسم المسافر',
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.grey200),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: passengerPhoneController,
                        focusNode: passengerPhoneFocusNode,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'رقم الهاتف',
                          prefixIcon: const Icon(Icons.phone_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.grey200),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // قائمة المحطات من الباك أند
                Expanded(
                  child: stationsAsync.when(
                    data: (stations) {
                      final query = isOriginFocused
                          ? originController.text.toLowerCase()
                          : destinationController.text.toLowerCase();

                      final filtered = stations.where((s) =>
                          s.name.toLowerCase().contains(query) ||
                          s.city.toLowerCase().contains(query)).toList();

                      if (filtered.isEmpty && query.isNotEmpty) {
                        return const Center(child: Text("لا توجد محطات تطابق بحثك"));
                      }
                      
                      final displayList = query.isEmpty ? stations : filtered;

                      return ListView.separated(
                        itemCount: displayList.length,
                        separatorBuilder: (context, index) => Divider(color: AppColors.grey200),
                        itemBuilder: (context, index) {
                          final station = displayList[index];
                          return ListTile(
                            leading: const Icon(Icons.location_on_outlined),
                            title: Text(station.name),
                            subtitle: Text(station.city),
                            onTap: () => _onStationSelected(station),
                          );
                        },
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, __) => Center(child: Text("خطأ في تحميل المحطات: $e")),
                  ),
                ),
                
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final state = ref.read(searchLocationProvider);
                    if (state.currentLocation != null && state.destination != null) {
                      context.push('/home/results', extra: BusSearchCriteria(
                        from: state.currentLocation!.name,
                        to: state.destination!.name,
                        fromId: state.currentLocation!.id,
                        toId: state.destination!.id,
                        date: DateTime.now(),
                        passengerName: passengerNameController.text,
                        passengerPhone: passengerPhoneController.text,
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('يرجى اختيار محطة الانطلاق والوصول')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainButton,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "بحث عن رحلات",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
