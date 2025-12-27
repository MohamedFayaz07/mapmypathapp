import 'package:flutter/material.dart';
import 'package:mapmypathapp/screens/ai_assistant_screen.dart';
import 'dashboard_screen.dart';
import 'explore_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  final String? username;

  const MainScreen({super.key, this.username});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      DashboardScreen(username: widget.username), // Home tab
      ExplorePage(), // Explore tab
      const AIScreen(), // AI tab
      const SettingsScreen(), // Settings tab
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Display the current screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Set the current index
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the index when a tab is tapped
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, // Ensures all tabs are visible
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: "Explore",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: "AI",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
