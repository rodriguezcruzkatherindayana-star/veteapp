import 'package:material_ui/material_ui.dart';

import 'core/theme/app_theme.dart';
import 'screens/login/login_screen.dart';

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
      home: const LoginScreen(),
    );
  }
}
