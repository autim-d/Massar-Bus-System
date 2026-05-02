import 'dart:io';
void main() {
  final files = [
    'lib/core/widgets/custom_text_field.dart',
    'lib/features/account/screens/account_details_form_screen.dart',
    'lib/features/account/screens/account_screen.dart',
    'lib/features/account/screens/edit_photo_screen.dart',
    'lib/features/account/screens/edit_profile_screen.dart',
    'lib/features/account/screens/profile_screen.dart',
    'lib/features/account/widgets/profile_header_widget.dart',
    'lib/features/auth/screens/enter_code_screen.dart',
    'lib/features/auth/screens/login_screen.dart',
    'lib/features/auth/screens/phone_login_screen.dart',
    'lib/features/auth/screens/splash_screen.dart',
    'lib/features/auth/screens/verification_method_screen.dart',
    'lib/features/home/screens/home_screen.dart',
    'lib/features/home/screens/location_search_screen.dart',
    'lib/features/ticket/screens/order_summary_screen.dart',
    'lib/features/ticket/screens/payment_success_screen.dart',
    'lib/features/ticket/screens/ticket_list_screen.dart',
    'lib/main.dart'
  ];
  for (var f in files) {
    final file = File('Massar-Bus-System/massar_project/' + f);
    if (!file.existsSync()) continue;
    final lines = file.readAsLinesSync();
    bool inConflict = false;
    for (var i = 0; i < lines.length; i++) {
      if (lines[i].startsWith('<<<<<<<')) {
        if (!inConflict) print('--- ' + f + ' ---');
        inConflict = true;
      }
      if (inConflict) {
        print(lines[i]);
      }
      if (lines[i].startsWith('>>>>>>>')) {
        inConflict = false;
      }
    }
  }
}
