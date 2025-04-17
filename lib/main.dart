import 'package:black_ants_app/app_theme.dart';
import 'package:black_ants_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for system UI overlay style
import 'package:black_ants_app/config/app_constants.dart';

void main() {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Optional: Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Optional: Customize system UI overlay style for consistent branding
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppConstants.primaryBlack, // Match AppBar
    statusBarIconBrightness: Brightness.light, // Icons on status bar (light for dark background)
    systemNavigationBarColor: AppConstants.offBlack, // Match Bottom Nav Bar
    systemNavigationBarIconBrightness: Brightness.light,
  ));


  runApp(const BlackAntsApp());
}

class BlackAntsApp extends StatelessWidget {
  const BlackAntsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlackAnts',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false, // Disable debug banner
      home: const SplashScreen(), // Start with the splash screen
    );
  }
}
