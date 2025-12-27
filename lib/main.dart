// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mapmypathapp/firebase_options.dart';
import 'package:mapmypathapp/screens/ai_assistant_screen.dart';
import 'package:mapmypathapp/screens/explore_screen.dart';
import 'package:mapmypathapp/screens/frontend_screen.dart';
import 'package:mapmypathapp/screens/settings_screen.dart';
//import 'package:mapmypathapp/screens/role_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/role_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MapMyPath',
      theme: ThemeData.light(),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,

      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/role': (context) => const RoleSelectionScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/explore': (context) => ExplorePage(),
        '/main': (context) => MainScreen(username: ModalRoute.of(context)?.settings.arguments as String?),
        '/ai': (context) => AIScreen(),
        '/settings': (context) => SettingsScreen(),
        '/frontend': (context) => FrontendRoadmapScreen(),
      },
    );
  }
}
