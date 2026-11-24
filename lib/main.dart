
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const VeteApp());
}

class VeteApp extends StatelessWidget {
  const VeteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VeteApp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const Scaffold(
        body: Center(
          child: Text('Bienvenido a VeteApp'),
        ),
      ),
    );
  }
}
