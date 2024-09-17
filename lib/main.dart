import 'package:flutter/material.dart';
import 'package:omnisell_crm/app_config/app_config.dart';
import 'package:omnisell_crm/presentation/lead_screen/controller/lead_controller.dart';
import 'package:omnisell_crm/presentation/lead_screen/view/lead_screen.dart';
import 'package:omnisell_crm/presentation/login_screen/controlller/login_controller.dart';
import 'package:omnisell_crm/presentation/login_screen/view/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn = prefs.getBool(AppConfig.loggedIn) ?? false;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LoginController()),
    ChangeNotifierProvider(create: (context) => LeadsController()),
  ], child: MyApp(isLoggedIn: loggedIn)));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const LeadScreen() : const LoginScreen(),
    );
  }
}
