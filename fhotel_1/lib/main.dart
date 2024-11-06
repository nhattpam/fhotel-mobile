import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await _initializeSessionManager();
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

Future<void> _initializeSessionManager() async {
  final sessionManager = SessionManager();
  await sessionManager.init();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Determine if the user is a customer or guest
    bool isCustomer = _isCustomer();
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'hotel',
          debugShowCheckedModeBanner: false,
          initialRoute: isCustomer ? AppRoutes.homePage : AppRoutes.homePage,
          routes: AppRoutes.routes,
        );
      },
    );
  }

  bool _isCustomer() {
    final sessionManager = SessionManager();
    bool isGuest = sessionManager.getGuest() == 'guest';
    bool isLoggedIn = sessionManager.getUserId()?.isNotEmpty ?? false;
    return isGuest || isLoggedIn;
  }
}
