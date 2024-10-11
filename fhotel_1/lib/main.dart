import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/app_export.dart';
var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await _initializeSessionManager();
  ThemeHelper().changeTheme('primary');
  runApp(MyApp()) ;
}

Future<void> _initializeSessionManager() async {
  final sessionManager = SessionManager();
  await sessionManager.init();
}
class MyApp extends StatelessWidget {
  bool isCustomer = SessionManager().getUserId()?.isNotEmpty ?? false;
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'hotel',
          debugShowCheckedModeBanner: false,
          initialRoute: isCustomer
              ? AppRoutes.homePage
              : AppRoutes.initialRoute,
          routes: AppRoutes.routes,
        );
      },
    );
  }

}