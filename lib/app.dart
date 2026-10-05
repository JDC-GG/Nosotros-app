import 'package:flutter/material.dart';

import 'screens/home/home_screen.dart';

class NosotrosApp extends StatelessWidget {
  const NosotrosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nosotros',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE85D75),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8F7),
      ),
      home: const HomeScreen(),
    );
  }
}