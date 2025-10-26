import 'package:flutter/material.dart';
import 'app_router.dart';

void main() {
  runApp(const InkFlowApp());
}

class InkFlowApp extends StatefulWidget {
  const InkFlowApp({super.key});

  @override
  State<InkFlowApp> createState() => _InkFlowAppState();
}

class _InkFlowAppState extends State<InkFlowApp> {
  ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'InkFlow',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: themeMode,
      routerConfig: InkFlowRouter.router,
    );
  }
}
