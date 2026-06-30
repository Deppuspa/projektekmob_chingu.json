import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const SaveBiteApp());
}

class SaveBiteApp extends StatelessWidget {
  const SaveBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SaveBite',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}