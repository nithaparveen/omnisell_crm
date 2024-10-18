import 'package:flutter/material.dart';
import 'package:omnisell_crm/app_config/app_config.dart';
import 'package:omnisell_crm/presentation/bottom_navigation_screen/controller/bottom_navigation_controller.dart';
import 'package:omnisell_crm/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import 'package:omnisell_crm/presentation/communication_logs_screen/controller/communication_controller.dart';
import 'package:omnisell_crm/presentation/follow_up_screen/controller/follow_up_controller.dart';
import 'package:omnisell_crm/presentation/lead_detail_screen/controller/lead_detail_controller.dart';
import 'package:omnisell_crm/presentation/lead_screen/controller/lead_controller.dart';
import 'package:omnisell_crm/presentation/login_screen/controlller/login_controller.dart';
import 'package:omnisell_crm/presentation/login_screen/view/login_screen.dart';
import 'package:omnisell_crm/presentation/payments_screen/controller/payment_controller.dart';
import 'package:omnisell_crm/presentation/task_screen/controller/task_controller.dart';
import 'package:omnisell_crm/presentation/timeline_screen/controller/timeline_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn = prefs.getBool(AppConfig.loggedIn) ?? false;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LoginController()),
    ChangeNotifierProvider(create: (context) => BottomNavigationController()),
    ChangeNotifierProvider(create: (context) => LeadsController()),
    ChangeNotifierProvider(create: (context) => LeadDetailsController()),
    ChangeNotifierProvider(create: (context) => TImeLineController()),
    ChangeNotifierProvider(create: (context) => FollowUpController()),
    ChangeNotifierProvider(create: (context) => PaymentController()),
    ChangeNotifierProvider(create: (context) => TaskController()),
    ChangeNotifierProvider(create: (context) => CommunicationController()),
  ], child: MyApp(isLoggedIn: loggedIn)));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const BottomNavBar() : const LoginScreen(),
    );
  }
}
