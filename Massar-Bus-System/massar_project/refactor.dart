import 'dart:io';

void main() async {
  final Map<String, String> renames = {
    'Bawazir_Screens/Pages/home.dart': 'features/home/screens/home_screen.dart',
    'Bawazir_Screens/Pages/login.dart': 'features/auth/screens/login_screen.dart',
    'Bawazir_Screens/Pages/phonelogin.dart': 'features/auth/screens/phone_login_screen.dart',
    'Bawazir_Screens/Pages/spalsh.dart': 'features/auth/screens/splash_screen.dart',
    'Bawazir_Screens/Pages/EnterCodePage.dart': 'features/auth/screens/enter_code_screen.dart',
    'Bawazir_Screens/Pages/VerificationMethodPage.dart': 'features/auth/screens/verification_method_screen.dart',
    'ahmed/LocationSearchPage.dart': 'features/home/screens/location_search_screen.dart',
    'ahmed/OrderSummary.dart': 'features/ticket/screens/order_summary_screen.dart',
    'ahmed/PaymentContinuationScreen copy.dart': 'features/ticket/screens/payment_continuation_screen.dart',
    'ahmed/tickect_screen.dart': 'features/ticket/screens/ticket_list_screen.dart',
    'khalil/acount.dart': 'features/account/screens/account_screen.dart',
    'khalil/app_colors.dart': 'core/theme/app_colors.dart',
    'khalil/profile.dart': 'features/account/screens/profile_screen.dart',
    'detail_ticket_page.dart': 'features/ticket/screens/detail_ticket_screen.dart',
    'payment_success_page.dart': 'features/ticket/screens/payment_success_screen.dart',
    'account_details_form_page.dart': 'features/account/screens/account_details_form_screen.dart',
    'edit_profile_screen.dart': 'features/account/screens/edit_profile_screen.dart',
    'edit_photo_screen.dart': 'features/account/screens/edit_photo_screen.dart',
  };

  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    print('lib directory not found');
    return;
  }

  // 1. Rename and move files
  for (var entry in renames.entries) {
    var oldFile = File('lib/${entry.key}');
    var newFile = File('lib/${entry.value}');
    
    // Ensure parent dir exists
    if (!newFile.parent.existsSync()) {
      newFile.parent.createSync(recursive: true);
    }
    
    if (oldFile.existsSync()) {
      oldFile.renameSync(newFile.path);
      print('Moved: ${entry.key} -> ${entry.value}');
    } else {
      print('Not Found (Skipped): ${entry.key}');
    }
  }

  // 2. Find and replace imports in all dart files in lib
  var dartFiles = libDir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));
  
  for (var file in dartFiles) {
    var content = file.readAsStringSync();
    var newContent = content;

    for (var entry in renames.entries) {
      newContent = newContent.replaceAll(entry.key, entry.value);
    }

    // Also we need to fix relative imports if they exist. (e.g. `import '../../ahmed/OrderSummary.dart';` -> `import '../../features/ticket/screens/order_summary_screen.dart';`)
    // Because replacing just the suffix works for `package:massar_project/ahmed/OrderSummary.dart`.
    // But honestly, the developers might have used relative paths like `../ahmed/tickect_screen.dart`.
    // Let's replace just the old suffixes with new suffixes, but wait! The slashes might mismatch. 
    // The previous loop will replace occurrences of 'ahmed/tickect_screen.dart' inside any string 'package:massar_project/ahmed/tickect_screen.dart'.
    // If it's relative like `../ahmed/tickect_screen.dart`, it will ALSO be replaced correctly!

    if (content != newContent) {
      file.writeAsStringSync(newContent);
      print('Updated imports in: ${file.path}');
    }
  }

  print('Done!');
}
