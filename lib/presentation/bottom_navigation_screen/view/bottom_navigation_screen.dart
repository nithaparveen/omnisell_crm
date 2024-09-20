import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import '../../lead_screen/view/lead_screen.dart';
import '../controller/bottom_navigation_controller.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    Provider.of<BottomNavigationController>(context, listen: false)
        .selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Consumer<BottomNavigationController>(
        builder: (context, provider, child) {
          return IndexedStack(
            index: provider.selectedIndex,
            children: const [
              LeadScreen(),
              LeadScreen(),
              LeadScreen(),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<BottomNavigationController>(
        builder: (context, controller, _) {
          return SlidingClippedNavBar(
            selectedIndex: controller.selectedIndex,
            onButtonPressed: (index) {
              controller.selectedIndex = index;
              setState(() {});
            },
            barItems: [
              BarItem(
                icon: Icons.dashboard_outlined,
                title: 'Leads',
              ),
              BarItem(
                icon: Icons.dashboard_outlined,
                title: 'Leads',
              ),
              BarItem(
                icon: Icons.dashboard_outlined,
                title: 'Leads',
              ),
            ],
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
            backgroundColor: Colors.white,
            iconSize: 18,
          );
        },
      ),
    );
  }
}
